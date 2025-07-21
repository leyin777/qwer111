import os, uuid, shutil, tempfile, threading
from datetime import datetime
from fastapi import APIRouter, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
from PIL import Image
import easyocr
from pptx import Presentation
from docx import Document
import pdfplumber
import olefile
from pdf2image import convert_from_path

router = APIRouter()

# ---------- 统一 OCR ----------
ocr = easyocr.Reader(['ch_sim', 'en'], gpu=False)

# ---------- 工具函数 ----------
def extract_txt(p):
    return open(p, encoding="utf-8").read()

def extract_pptx(p):
    from pptx.enum.shapes import MSO_SHAPE_TYPE
    prs = Presentation(p)
    lines = []
    for s in prs.slides:
        lines += [sh.text.strip() for sh in s.shapes if hasattr(sh, "text") and sh.text.strip()]
        if s.has_notes_slide and s.notes_slide.notes_text_frame:
            lines.append(s.notes_slide.notes_text_frame.text.strip())
        for sh in s.shapes:
            if sh.shape_type == MSO_SHAPE_TYPE.PICTURE:
                img = Image.open(io.BytesIO(sh.image.blob)).convert("RGB")
                res = ocr.readtext(np.array(img), detail=0)
                lines.extend(res)
    return "\n".join(lines)

def extract_pdf(p):
    full_text = []
    with pdfplumber.open(p) as pdf:
        for page in pdf.pages:
            txt = page.extract_text() or ""
            if txt.strip():
                full_text.append(txt)
            else:
                img = convert_from_path(
                    p, dpi=300, first_page=page.page_number, last_page=page.page_number, thread_count=1
                )[0]
                res = ocr.readtext(np.array(img), detail=0)
                full_text.extend(res)
    return "\n".join(full_text)

def extract_docx(p):
    lines = [para.text.strip() for para in Document(p).paragraphs if para.text.strip()]
    for t in Document(p).tables:
        lines += [c.text.strip() for r in t.rows for c in r.cells if c.text.strip()]
    return "\n".join(lines)

def extract_doc(p):
    if not olefile.isOleFile(p):
        return ""
    lines = []
    with olefile.OleFileIO(p) as ole:
        if ole.exists('WordDocument'):
            data = ole.openstream('WordDocument').read()
            text_start = int.from_bytes(data[0x24A:0x24C], 'little')
            text_len = int.from_bytes(data[0x44C:0x44E], 'little')
            raw = data[text_start:text_start+text_len*2]
            lines.append(raw.decode('utf-16-le', errors='ignore'))
    return "\n".join(lines)

# ---------- FastAPI 路由 ----------
import numpy as np
import io

@router.post("/extract")
async def extract_text(file: UploadFile = File(...)):
    ext = os.path.splitext(file.filename)[-1].lower()
    if ext not in {".txt", ".ppt", ".pptx", ".pdf", ".doc", ".docx"}:
        raise HTTPException(status_code=400, detail="Unsupported file type")
    tmp = os.path.join(tempfile.gettempdir(), f"{uuid.uuid4()}{ext}")
    with open(tmp, "wb") as f:
        shutil.copyfileobj(file.file, f)
    try:
        text = {
            ".txt": extract_txt,
            ".pptx": extract_pptx,
            ".ppt": extract_pptx,
            ".pdf": extract_pdf,
            ".docx": extract_docx,
            ".doc": extract_doc,
        }[ext](tmp)
    finally:
        os.remove(tmp)
    return JSONResponse(content={
        "filename": file.filename,
        "text": text,
        "length": len(text),
        "timestamp": datetime.now().isoformat()
    })