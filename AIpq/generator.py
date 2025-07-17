
import os, json
from fastapi import APIRouter, Form
import openai

router = APIRouter()

client = openai.OpenAI(
    api_key=os.getenv("OPENAI_API_KEY", "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"),
    base_url=os.getenv("OPENAI_BASE_URL", "https://openrouter.ai/api/v1")
)

SYS_GEN = (
    "你是严格的中文出题专家。请基于用户文本生成一道高难度四选一选择题。"
    "返回严格 JSON：{\"stem\":\"\",\"A\":\"\",\"B\":\"\",\"C\":\"\",\"D\":\"\",\"correct\":\"A|B|C|D\"}。"
    "仅一个选项完全正确，其余高迷惑。"
)
SYS_EVAL = (
    "请给上述中文题目打分（0-1）并说明理由，返回严格 JSON：{\"score\":0.00,\"reason\":\"...\"}。"
    "深度0.5，迷惑性0.3，与原文一致性0.2。"
)

@router.post("/generate")
def generate_question(
    text: str = Form(...),
    prev: str = Form("")
):
    msgs = [{"role": "system", "content": SYS_GEN},
            {"role": "user", "content": text[:1500]}]
    if prev:
        msgs.append({"role": "user", "content": f"上一轮评估：{prev}，请提高难度。"})

    q_raw = client.chat.completions.create(
        model="moonshotai/kimi-k2:free",
        messages=msgs,
        max_tokens=800,
        temperature=0.5,
        timeout=8
    ).choices[0].message.content

    eval_msgs = [{"role": "system", "content": SYS_EVAL},
                 {"role": "assistant", "content": q_raw},
                 {"role": "user", "content": text[:1000]}]
    meta_raw = client.chat.completions.create(
        model="moonshotai/kimi-k2:free",
        messages=eval_msgs,
        max_tokens=200,
        temperature=0,
        timeout=2
    ).choices[0].message.content

    return {
        "question": json.loads(q_raw),
        "meta": json.loads(meta_raw)
    }