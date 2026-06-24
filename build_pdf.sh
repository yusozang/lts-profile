#!/usr/bin/env bash
# pdf_source.html을 이태성_프로필.pdf로 재생성하는 빌드 스크립트 (WeasyPrint)
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib \
  uv run --with weasyprint --with pypdf python - "$DIR" <<'PY'
import sys
from pathlib import Path
from weasyprint import HTML
from pypdf import PdfReader

base = Path(sys.argv[1])
src = base / "pdf_source.html"
out = base / "이태성_프로필.pdf"

HTML(filename=str(src), base_url=str(base)).write_pdf(str(out))

# 생성 검증 — 페이지 수와 크기를 출력
reader = PdfReader(str(out))
print(f"[OK] PDF 재생성 완료: {out}")
print(f"     {len(reader.pages)}쪽 · {out.stat().st_size:,} bytes")
PY
