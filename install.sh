#!/bin/bash
# ============================================================
# Antigravity RTL Support Installer v5.0
# دعم RTL لتطبيق Antigravity
# ============================================================
# Patches 4 files:
#   1. workbench.html        — Main fix: dir + CSS RTL/LTR
#   2. cascade-panel.html    — Chat panel RTL
#   3. index.html            — Webview content RTL
#   4. markdown.css          — Markdown preview RTL
# ============================================================

ANTIGRAVITY_DIR="/usr/share/antigravity/resources/app"
WORKBENCH_FILE="$ANTIGRAVITY_DIR/out/vs/code/electron-browser/workbench/workbench.html"
CASCADE_FILE="$ANTIGRAVITY_DIR/extensions/antigravity/cascade-panel.html"
WEBVIEW_FILE="$ANTIGRAVITY_DIR/out/vs/workbench/contrib/webview/browser/pre/index.html"
MARKDOWN_CSS="$ANTIGRAVITY_DIR/extensions/markdown-language-features/media/markdown.css"

RTL_MARKER="Antigravity RTL"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Antigravity RTL Support v5.0           ║${NC}"
echo -e "${BLUE}║   دعم اللغة العربية في Antigravity        ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# --- Check permissions ---
if [ ! -w "$ANTIGRAVITY_DIR" ]; then
    echo -e "${YELLOW}⚠ يجب تشغيل السكريبت بصلاحيات sudo${NC}"
    echo "  sudo bash install.sh"
    exit 1
fi

# --- Check Antigravity exists ---
if [ ! -f "$WORKBENCH_FILE" ]; then
    echo -e "${RED}✗ لم يتم العثور على Antigravity في المسار:${NC}"
    echo "  $ANTIGRAVITY_DIR"
    exit 1
fi

# ============================================================
# UNINSTALL MODE
# ============================================================
if [ "$1" = "--uninstall" ] || [ "$1" = "-u" ]; then
    echo -e "${YELLOW}🔄 إلغاء التثبيت — استعادة الملفات الأصلية...${NC}"
    RESTORED=0

    for FILE in "$WORKBENCH_FILE" "$CASCADE_FILE" "$WEBVIEW_FILE" "$MARKDOWN_CSS"; do
        if [ -f "${FILE}.bak" ]; then
            cp "${FILE}.bak" "$FILE"
            echo -e "  ${GREEN}✓${NC} استعادة: $(basename $FILE)"
            RESTORED=$((RESTORED + 1))
        fi
    done

    if [ $RESTORED -eq 0 ]; then
        echo -e "${RED}✗ لا توجد نسخ احتياطية لاستعادتها${NC}"
    else
        echo -e "\n${GREEN}✓ تم إلغاء التثبيت بنجاح! أعد تشغيل Antigravity.${NC}"
    fi
    exit 0
fi

# ============================================================
# INSTALL
# ============================================================
echo -e "${GREEN}▶ بدء التثبيت...${NC}\n"

PATCHED=0
SKIPPED=0

# ----------------------------------------------------------
# 1. WORKBENCH.HTML — الملف الرئيسي (أهم تعديل)
# ----------------------------------------------------------
echo -e "${BLUE}[1/4] workbench.html (الملف الرئيسي)${NC}"
if grep -q "$RTL_MARKER" "$WORKBENCH_FILE" 2>/dev/null; then
    echo -e "  ${YELLOW}⟳ تعديل RTL موجود مسبقًا — تخطي${NC}"
    SKIPPED=$((SKIPPED + 1))
else
    # Backup
    if [ ! -f "${WORKBENCH_FILE}.bak" ]; then
        cp "$WORKBENCH_FILE" "${WORKBENCH_FILE}.bak"
        echo -e "  ${GREEN}✓${NC} نسخة احتياطية"
    fi

    # Read original CSP and reconstruct file
    cat > "$WORKBENCH_FILE" << 'WORKBENCH_EOF'
<!-- Copyright (C) Microsoft Corporation. All rights reserved. -->
<!DOCTYPE html>
<html dir="rtl">

<head>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Security-Policy" content="
				default-src
					'none'
				;
				img-src
					'self'
					data:
					blob:
					vscode-remote-resource:
					vscode-managed-remote-resource:
					https:
				;
				media-src
					'self'
					data:
					blob:
					https://www.gstatic.com/
				;
				frame-src
					'self'
					vscode-webview:
				;
				script-src
					'self'
					'unsafe-eval'
					blob:
				;
				style-src
					'self'
					'unsafe-inline'
				;
				connect-src
					'self'
					data:
					http://127.0.0.1:*
					http://jetski-unleash.corp.goog/
					http://antigravity-unleash.goog/
					https:
					ws:
				;
				font-src
					'self'
					vscode-remote-resource:
					vscode-managed-remote-resource:
					https://*.vscode-unpkg.net
				;
				require-trusted-types-for
					'script'
				;
				trusted-types
					amdLoader
					cellRendererEditorText
					collapsedCellPreview
					defaultWorkerFactory
					diffEditorWidget
					diffReview
					domLineBreaksComputer
					dompurify
					dompurifyMermaid
					editorGhostText
					editorViewLayer
					mermaid
					notebookRenderer
					stickyScrollViewLayer
					tokenizeToString
					notebookChatEditController
					richScreenReaderContent
					renderCodeBlock
				;
		" />

	<!-- Workbench CSS -->
	<link rel="stylesheet" href="../../../workbench/workbench.desktop.main.css">

	<!-- Antigravity RTL v5.0: RTL content + LTR UI -->
	<style>
		/* Main workbench: RTL for content areas */
		.monaco-workbench { direction: rtl !important; }

		/* === UI Components: force LTR === */
		.part.titlebar { direction: ltr !important; }
		.menubar, .menubar-menu-button, .monaco-menu { direction: ltr !important; }
		.part.activitybar { direction: ltr !important; }
		.part.sidebar { direction: ltr !important; }
		.part.editor>.content>.editor-group-container>.title { direction: ltr !important; }
		.tabs-container { direction: ltr !important; }
		.part.statusbar { direction: ltr !important; }
		.part.panel { direction: ltr !important; }
		.context-view, .monaco-menu-container { direction: ltr !important; }
		.quick-input-widget { direction: ltr !important; }
		.suggest-widget { direction: ltr !important; }
		.notifications-toasts { direction: ltr !important; }
		.monaco-dialog-box { direction: ltr !important; }
		.find-widget, .findWidget { direction: ltr !important; }
		.breadcrumbs-below-tabs { direction: ltr !important; }
		.monaco-scrollable-element>.scrollbar { direction: ltr !important; }
		.minimap { direction: ltr !important; }
		.monaco-action-bar { direction: ltr !important; }
		.monaco-list { direction: ltr !important; }

		/* Code editors: always LTR */
		.monaco-editor .view-lines,
		.monaco-editor .view-line,
		.monaco-editor .lines-content {
			direction: ltr !important;
			text-align: left !important;
		}
		code, pre, .hljs {
			direction: ltr !important;
			text-align: left !important;
		}
	</style>
</head>

<body aria-label="">
</body>

<!-- Startup (do not modify order of script tags!) -->
<script src="./workbench.js" type="module"></script>

</html>
WORKBENCH_EOF

    echo -e "  ${GREEN}✓${NC} تم تطبيق dir=rtl + CSS RTL/LTR"
    PATCHED=$((PATCHED + 1))
fi
echo ""

# ----------------------------------------------------------
# 2. CASCADE-PANEL.HTML — نافذة الدردشة
# ----------------------------------------------------------
echo -e "${BLUE}[2/4] cascade-panel.html (نافذة الدردشة)${NC}"
if grep -q "$RTL_MARKER" "$CASCADE_FILE" 2>/dev/null; then
    echo -e "  ${YELLOW}⟳ تعديل RTL موجود مسبقًا — تخطي${NC}"
    SKIPPED=$((SKIPPED + 1))
else
    # Backup
    if [ ! -f "${CASCADE_FILE}.bak" ]; then
        cp "$CASCADE_FILE" "${CASCADE_FILE}.bak"
        echo -e "  ${GREEN}✓${NC} نسخة احتياطية"
    fi

    # Create patched version
    cat > "$CASCADE_FILE" << 'CASCADE_EOF'
<!doctype html>
<html>

<head>
  <style>
    /* --- Antigravity RTL v5.0 (Smart Auto-Detection) --- */

    /* Base RTL */
    body, html, *, *::before, *::after {
      unicode-bidi: plaintext !important;
      text-align: start !important;
    }

    /* Tailwind Typography (prose) overrides */
    .prose, .prose *, [class*="prose"] *,
    .markdown-body, .markdown-body *,
    .rendered-markdown, .rendered-markdown *,
    .react-app-container, .review-container {
      unicode-bidi: plaintext !important;
      text-align: start !important;
    }

    .prose h1, .prose h2, .prose h3, .prose h4, .prose h5, .prose h6,
    [class*="prose"] h1, [class*="prose"] h2, [class*="prose"] h3,
    h1, h2, h3, h4, h5, h6 {
      unicode-bidi: plaintext !important;
      text-align: start !important;
    }

    .prose p, .prose div, .prose span, .prose li, .prose td, .prose th,
    [class*="prose"] p, [class*="prose"] div, [class*="prose"] span,
    p, div, span, section, article, li {
      unicode-bidi: plaintext !important;
      text-align: start !important;
    }

    .prose ul, .prose ol, [class*="prose"] ul, [class*="prose"] ol,
    ul, ol {
      unicode-bidi: plaintext !important;
      text-align: start !important;
      padding-inline-start: 1.625em !important;
      padding-left: unset !important;
      padding-right: unset !important;
    }

    .prose li, [class*="prose"] li, li {
      unicode-bidi: plaintext !important;
      text-align: start !important;
      padding-inline-start: 0.375em !important;
      padding-left: unset !important;
      margin-left: unset !important;
    }

    .prose table, [class*="prose"] table, table {
      unicode-bidi: plaintext !important;
      width: 100% !important;
    }

    .prose th, .prose td, [class*="prose"] th, [class*="prose"] td,
    th, td {
      unicode-bidi: plaintext !important;
      text-align: start !important;
      padding-inline-start: 12px !important;
      padding-inline-end: 12px !important;
    }

    .prose blockquote, [class*="prose"] blockquote, blockquote {
      unicode-bidi: plaintext !important;
      text-align: start !important;
      border-left: none !important;
      border-right: none !important;
      border-inline-start: 4px solid #007acc !important;
      border-inline-end: none !important;
      padding-inline-start: 1em !important;
      padding-inline-end: 0 !important;
      padding-left: unset !important;
      margin-inline-start: 0 !important;
    }

    /* Code ALWAYS stays LTR */
    code, pre, .code-block, kbd, samp, var,
    pre code, code pre, .highlight, .hljs,
    .prose code, .prose pre, [class*="prose"] code, [class*="prose"] pre {
      direction: ltr !important;
      unicode-bidi: normal !important;
      text-align: left !important;
    }

    input, textarea {
      unicode-bidi: plaintext !important;
      text-align: start !important;
    }

    /* --- End RTL v5.0 --- */
  </style>
</head>

<body style="margin: 0">
  <div id="react-app" class="react-app-container"></div>
</body>

</html>
CASCADE_EOF

    echo -e "  ${GREEN}✓${NC} تم تطبيق RTL CSS"
    PATCHED=$((PATCHED + 1))
fi
echo ""

# ----------------------------------------------------------
# 3. INDEX.HTML — Webview
# ----------------------------------------------------------
echo -e "${BLUE}[3/4] index.html (Webview)${NC}"
if grep -q "$RTL_MARKER" "$WEBVIEW_FILE" 2>/dev/null; then
    echo -e "  ${YELLOW}⟳ تعديل RTL موجود مسبقًا — تخطي${NC}"
    SKIPPED=$((SKIPPED + 1))
else
    # Backup
    if [ ! -f "${WEBVIEW_FILE}.bak" ]; then
        cp "$WEBVIEW_FILE" "${WEBVIEW_FILE}.bak"
        echo -e "  ${GREEN}✓${NC} نسخة احتياطية"
    fi

    # Inject RTL CSS into toContentHtml function
    RTL_INJECT='/* Antigravity RTL v5.0 */\nconst rtlStyle = newDocument.createElement("style");\nrtlStyle.textContent = `\n  html, body, *, *::before, *::after { unicode-bidi: plaintext !important; text-align: start !important; }\n  .markdown-body, .rendered-markdown { unicode-bidi: plaintext !important; text-align: start !important; }\n  h1,h2,h3,h4,h5,h6,p,div,span,li,td,th { unicode-bidi: plaintext !important; text-align: start !important; }\n  ul, ol { padding-inline-start: 2em !important; }\n  blockquote { border-left: none !important; border-inline-start: 4px solid #007acc !important; padding-inline-start: 1em !important; }\n  code, pre, .hljs { direction: ltr !important; unicode-bidi: normal !important; text-align: left !important; }\n`;\nnewDocument.head.appendChild(rtlStyle);'

    sed -i "/const newDocument = new DOMParser/a\\$RTL_INJECT" "$WEBVIEW_FILE"

    if grep -q "Antigravity RTL" "$WEBVIEW_FILE"; then
        echo -e "  ${GREEN}✓${NC} تم حقن RTL CSS في toContentHtml()"
        PATCHED=$((PATCHED + 1))
    else
        echo -e "  ${RED}✗ فشل تطبيق التعديل${NC}"
    fi
fi
echo ""

# ----------------------------------------------------------
# 4. MARKDOWN.CSS — معاينة Markdown
# ----------------------------------------------------------
echo -e "${BLUE}[4/4] markdown.css (معاينة Markdown)${NC}"
if grep -q "$RTL_MARKER" "$MARKDOWN_CSS" 2>/dev/null; then
    echo -e "  ${YELLOW}⟳ تعديل RTL موجود مسبقًا — تخطي${NC}"
    SKIPPED=$((SKIPPED + 1))
else
    # Backup
    if [ ! -f "${MARKDOWN_CSS}.bak" ]; then
        cp "$MARKDOWN_CSS" "${MARKDOWN_CSS}.bak"
        echo -e "  ${GREEN}✓${NC} نسخة احتياطية"
    fi

    # Append RTL CSS
    cat >> "$MARKDOWN_CSS" << 'MDCSS_EOF'

/* --- Antigravity RTL v5.0 --- */
html, body { unicode-bidi: plaintext !important; text-align: start !important; }
h1,h2,h3,h4,h5,h6 { unicode-bidi: plaintext !important; text-align: start !important; }
p, div, span, section, article, li { unicode-bidi: plaintext !important; text-align: start !important; }
ul, ol { unicode-bidi: plaintext !important; padding-inline-start: 2em !important; }
th { text-align: start !important; }
td { unicode-bidi: plaintext !important; text-align: start !important; }
blockquote {
  unicode-bidi: plaintext !important; text-align: start !important;
  border-left-width: 0 !important; border-inline-start-width: 5px !important;
  border-inline-start-style: solid !important; padding-inline-start: 10px !important;
}
code, pre, .hljs { direction: ltr !important; unicode-bidi: normal !important; text-align: left !important; }
/* --- End RTL v5.0 --- */
MDCSS_EOF

    echo -e "  ${GREEN}✓${NC} تم إضافة RTL CSS"
    PATCHED=$((PATCHED + 1))
fi
echo ""

# ============================================================
# SUMMARY
# ============================================================
echo -e "${BLUE}══════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ اكتمل التثبيت!${NC}"
echo -e "  تم تعديل: ${GREEN}${PATCHED}${NC} ملفات"
if [ $SKIPPED -gt 0 ]; then
    echo -e "  تم تخطي: ${YELLOW}${SKIPPED}${NC} ملفات (معدّلة مسبقًا)"
fi
echo ""
echo -e "${YELLOW}⚠ أعد تشغيل Antigravity لتطبيق التغييرات${NC}"
echo ""
echo -e "  لإلغاء التثبيت: ${BLUE}sudo bash install.sh --uninstall${NC}"
echo -e "${BLUE}══════════════════════════════════════════${NC}"
