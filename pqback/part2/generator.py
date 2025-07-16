import os, json, time, openai
from pydantic import BaseModel
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from fastapi import Form
# 1) 用环境变量读 key（不写死）
client = openai.OpenAI(
    api_key="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",
    base_url="https://openrouter.ai/api/v1"
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

class In(BaseModel):
    text: str
    prev: str = ""

app = FastAPI()
@app.post("/v1/question")
def api(
    text: str = Form(...),
    prev: str = Form("")
):
    t0 = time.time()
    msgs = [{"role": "system", "content": SYS_GEN},
            {"role": "user",   "content": text[:1500]}]
    if prev:
        msgs.append({"role": "user", "content": f"上一轮评估：{prev}，请提高难度。"})

    # 用 kimi
    q_raw = client.chat.completions.create(
        model="moonshotai/kimi-k2:free",
        messages=msgs,
        max_tokens=600,
        temperature=0.5,
        timeout=8
    ).choices[0].message.content

    # 评估
    eval_msgs = [{"role": "system", "content": SYS_EVAL},
                 {"role": "assistant", "content": q_raw},
                 {"role": "user",   "content": text[:800]}]
    meta_raw = client.chat.completions.create(
        model="moonshotai/kimi-k2:free",
        messages=eval_msgs,
        max_tokens=200,
        temperature=0,
        timeout=2
    ).choices[0].message.content



    payload = {"question": json.loads(q_raw), "meta": json.loads(meta_raw)}
    return JSONResponse(content=payload)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
