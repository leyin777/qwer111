import openai
import os

# ---------- ChatAnywhere 客户端 ----------
client = openai.OpenAI(
    # 建议把 KEY 写进环境变量 OPENAI_API_KEY，这里仅兜底
    api_key=os.getenv("OPENAI_API_KEY", "sk-0bvTpHHrwhqnsTDAAHhY9I6CJSf5dEzm59RIM2h2tV2I9iZd"),
    # 去掉多余字符，只保留干净 URL
    base_url=os.getenv("OPENAI_BASE_URL", "https://api.chatanywhere.tech/v1")
)