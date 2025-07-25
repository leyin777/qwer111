
import json
from typing import List, Dict, Tuple
from fastapi import APIRouter, Form, HTTPException
from aiapiclient import client

router = APIRouter()
# ---------- 评分系统 ----------
SYS_EVAL = (
    "请给下列中文选择题打分（0–100）并说明理由。\n"
    "评分权重：深度50%，迷惑性30%，与原文一致性20%。\n"
    "对每道题返回 **严格 JSON 对象**，字段顺序固定：\n"
    "{\"score\": <0-100整数>, \"reason\": \"简要理由\"}\n"
    "最终输出 **JSON 数组**，长度必须与题目数一致，格式示例：\n"
    "[{\"score\": 85, \"reason\": \"题干深度足够，迷惑项合理\"}, ...]\n"
)
# ---------- 路由 ----------
@router.post("/generate")
async def generate_question(
    text: str = Form(...),
    n: int = Form(1),

):
    if not (1 <= n <= 5):
        raise HTTPException(400, "n 必须在 1~5之间")

    prompt = (
        f"你是严格的中文出题专家。请基于用户文本一次生成 {n} 道高难度四选一选择题。\n"
        "要求：\n"
        "1) 正确答案不要全A或全B或全C或全D！！！这条最重要\n"
        "2) 题目不能依赖该文本，如“根据文中”这类描述不应该出现，这条非常重要；\n"
        "3)每题四个选项中仅一个完全正确，其余三项必须高度迷惑；\n"
        "4) 每题题干必须考察对文本深层因果、论证结构或隐含前提的理解；\n"
        "5) 返回严格 JSON 数组，每条格式：\n"
        "[{\"stem\":\"\",\"A\":\"\",\"B\":\"\",\"C\":\"\",\"D\":\"\",\"correct\":\"\"}]"
    )

    def call_llm(messages: List[Dict], k: int) -> List[Dict]:
        resp = client.chat.completions.create(
            model="gpt-4.1-mini",
            messages=messages,
            max_tokens=800 + 200 * k,
            temperature=0.5,
            timeout=30
        )
        content = resp.choices[0].message.content
        content = content.strip().removeprefix("```json").removesuffix("```").strip()
        qs = json.loads(content)
        if not isinstance(qs, list) or len(qs) != k:
            raise ValueError("题数不符")
        return qs

    def evaluate_once(qs: List[Dict]) -> Tuple[int, List[Dict]]:
        """一次性评估，返回 (不及格数量, metas)"""
        eval_user = "原文：\n" + text + "\n\n题目列表：\n"
        for idx, q in enumerate(qs, 1):
            eval_user += f"{idx}. {json.dumps(q, ensure_ascii=False)}\n"
        msgs = [
            {"role": "system", "content": SYS_EVAL},
            {"role": "user", "content": eval_user}
        ]
        raw = client.chat.completions.create(
            model="gpt-4.1-nano",
            messages=msgs,
            max_tokens=150 + 60 * len(qs),
            temperature=0,
            timeout=10
        ).choices[0].message.content
        metas = json.loads(raw.strip().removeprefix("```json").removesuffix("```").strip())
        if not isinstance(metas, list) or len(metas) != len(qs):
            raise ValueError("评估格式错误")
        fail_cnt = sum(1 for m in metas if int(m.get("score", 0)) < 60)
        return fail_cnt, metas

    # ---------- 主循环 ----------
    max_retry = 3

    messages = [
        {"role": "system", "content": prompt},
        {"role": "user", "content": text}
    ]
    questions = call_llm(messages,n)
    for _ in range(max_retry):
        fail_cnt, metas = evaluate_once(questions)
        if fail_cnt == 0:
            break
        regen_messages =(
            f"你是严格的中文出题专家。请基于用户文本一次生成 {fail_cnt} 道高难度四选一选择题。\n"
            "要求：\n"
            "1) 正确选项分布随机，不要全是单一选项；\n"
            "2) 每题题干必须考察对文本深层因果、论证结构或隐含前提的理解；\n"
            "3) 题目不依赖该文本，非常重要；\n"
            "4) 每题四个选项中仅一个完全正确，其余三项必须高度迷惑；\n"
            "5) 返回严格 JSON 数组，每条格式：\n"
            "[{\"stem\":\"\",\"A\":\"\",\"B\":\"\",\"C\":\"\",\"D\":\"\",\"correct\":\"\"}]"
        )
        regen_messages = [
            {"role": "system", "content":regen_messages},
            {"role": "user", "content": f"原文：{text}\n上一轮 {fail_cnt} 题未达标，请重新生成。"}
        ]
        new_qs = call_llm(regen_messages, fail_cnt)

        idx = 0
        for i, m in enumerate(metas):
            if int(m.get("score", 0)) < 70:
                questions[i] = new_qs[idx]
                idx += 1
                if idx == len(new_qs):
                    break
    else:
        raise HTTPException(400, f"重试 {max_retry} 次后仍有题目未达标")


    return {"questions": questions, "metas": metas}