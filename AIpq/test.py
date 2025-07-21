import easyocr
import numpy as np
from PIL import Image

# 同时加载中文 + 英文模型
reader = easyocr.Reader(['ch_sim', 'en'], gpu=False)

def ocr_whole(img_path: str) -> str:
    img = Image.open(img_path).convert("RGB")
    # 直接整图识别
    results = reader.readtext(np.array(img), detail=0)
    return "\n".join(results).strip()

if __name__ == "__main__":
    print(ocr_whole("image.png"))