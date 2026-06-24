# CLAUDE.md — 이태성 프로필 사이트 작업 규칙

이 저장소(`lts-profile`)는 **하나의 인물 정보를 두 산출물**로 보여준다.

| 파일 | 용도 | 디자인 |
|------|------|--------|
| `index.html` | 웹페이지 (GitHub Pages) | 반응형 웹 레이아웃 |
| `pdf_source.html` | 프로필 PDF의 원본 | A4 인쇄용 레이아웃 |
| `이태성_프로필.pdf` | 배포·다운로드용 PDF | `pdf_source.html`에서 생성 |

두 HTML은 **디자인은 다르지만 담는 내용(경력·직함·수치·문구·연락처 등)은 동일**해야 한다. 한쪽만 고치면 다른 쪽과 PDF가 옛 정보로 남아 어긋난다.

## 수정 요청을 받으면 (필수 절차)

**내용(content) 변경**일 때 — 경력·직함·이름·날짜·수치·소개 문구·연락처·정책 항목 등:

1. `index.html`과 `pdf_source.html`을 **둘 다** 같은 의미로 수정한다. 한쪽만 고치고 끝내지 않는다.
2. `./build_pdf.sh`를 실행해 `이태성_프로필.pdf`를 재생성한다.
3. 재생성된 PDF에 변경 내용이 실제로 들어갔는지 확인한다(텍스트 추출로 검증).
4. `index.html`, `pdf_source.html`, `이태성_프로필.pdf`를 **함께 커밋·push**한다.

**웹 전용(web-only) 변경**일 때 — PDF에 없는 요소만 건드리는 경우:

- 책 미리보기 모달, 맨 위로 버튼, 네비게이션, 호버 효과, 갤러리 등 **PDF에 존재하지 않는 웹 전용 기능/스타일**은 `index.html`만 수정하면 된다. PDF 재생성 불필요.
- 판단 기준: 그 변경 대상이 `pdf_source.html`에도 존재하는가? 존재하면 내용 변경(둘 다), 없으면 웹 전용(index.html만).

## PDF 빌드

```bash
./build_pdf.sh
```

- `pdf_source.html` → `이태성_프로필.pdf`를 WeasyPrint로 재생성한다.
- 출력은 **이 폴더 안**(`이태성_프로필.pdf`)이다. 이 PDF는 사이트의 다운로드 링크(`index.html`의 `href="이태성_프로필.pdf"`)가 직접 참조하므로 데스크탑이 아니라 repo 안에 둔다.
- 의존성은 `uv run --with weasyprint`로 그때그때 가져오므로 사전 설치 불필요. macOS는 `DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib`가 스크립트에 포함돼 있다.

## 주의

- 이 PDF는 **개인 정치 프로필**이며, 회사(이시도르) PDF 표준·로고·색상 테마를 적용하지 않는다. `pdf_source.html`의 민주당 블루 테마를 그대로 유지한다.
- 한국 인명 영문 표기는 성-이름 순서를 따른다(예: `Lee Tae Sung`).
