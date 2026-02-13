#!/bin/bash
# -----------------------------------------------------------------------------
# Antigravity Enhanced RTL Support
# -----------------------------------------------------------------------------
# Description: Automatically enables smart Right-to-Left (RTL) support for 
#              Antigravity AI interface (Chat & Webviews), improving Arabic 
#              font rendering and text direction while preserving code blocks.
# Author:      Antigravity Community
# License:     MIT
# -----------------------------------------------------------------------------

set -e

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Enhanced RTL Support Patcher...${NC}"

# --- 1. Define Targets ---
# We now targets multiple files:
# 1. cascade-panel.html (Chat Interface)
# 2. index.html (Webview Container used for artifacts/markdown)

TARGETS=(
    "/usr/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "/opt/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "/usr/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "/opt/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "$HOME/.local/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
)

# Detect actually existing files
FOUND_TARGETS=()
for path in "${TARGETS[@]}"; do
    if [ -f "$path" ]; then
        FOUND_TARGETS+=("$path")
    fi
done

if [ ${#FOUND_TARGETS[@]} -eq 0 ]; then
    echo -e "${RED}❌ Error: Could not find any Antigravity interface files.${NC}"
    echo "   Please make sure Antigravity is installed correctly."
    exit 1
fi

echo -e "${BLUE}🔍 Found ${#FOUND_TARGETS[@]} target(s) to patch:${NC}"
for t in "${FOUND_TARGETS[@]}"; do
    echo "   - $t"
done

# --- 2. Permission Check ---
# Check if we need sudo for ANY of the found targets
NEED_SUDO=false
for t in "${FOUND_TARGETS[@]}"; do
    if [ ! -w "$t" ]; then
        NEED_SUDO=true
        break
    fi
done

if [ "$NEED_SUDO" = true ] && [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}🔒 One or more files are protected. Switching to sudo...${NC}"
    exec sudo "$0" "$@"
fi

# --- 3. The Payload (CSS) ---
CSS_CONTENT='
<style>
/* --- Smart RTL Support by Antigravity Community --- */
/* 1. Content-Aware Directionality */
.react-app-container, .markdown-body, .monaco-editor .view-line, p, h1, h2, h3, h4, li, body {
    unicode-bidi: plaintext !important;
    text-align: start !important;
    line-height: 1.6 !important;
    font-family: "Segoe UI", "Roboto", "Cairo", sans-serif !important;
}
/* 2. List Fixes */
ul, ol { padding-inline-start: 25px !important; }
li { list-style-position: outside !important; }
/* 3. Code Block Protection (Strict LTR) */
pre, code, .code-block, .monaco-editor .view-lines {
    direction: ltr !important;
    unicode-bidi: normal !important;
    text-align: left !important;
    font-family: "Fira Code", "Consolas", monospace !important;
}
</style>
'

# --- 4. Loop & Patch ---
for TARGET in "${FOUND_TARGETS[@]}"; do
    echo -e "${BLUE}🛠  Processing: $TARGET${NC}"

    # Idempotency Check
    if grep -q "Smart RTL Support" "$TARGET"; then
        echo -e "${GREEN}   ✅ Already patched.${NC}"
        continue
    fi

    # Backup
    BACKUP="${TARGET}.bak"
    if [ ! -f "$BACKUP" ]; then
        echo -e "${YELLOW}   📦 Creating backup: $BACKUP${NC}"
        cp "$TARGET" "$BACKUP"
    fi

    # Injection Logic
    echo -e "${YELLOW}   💉 Injecting RTL styles...${NC}"
    if grep -q "<\/head>" "$TARGET"; then
        awk -v css="$CSS_CONTENT" '/<\/head>/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
    elif grep -q "<body" "$TARGET"; then
        awk -v css="<head>$CSS_CONTENT</head>" '/<body/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
    else
        cat "$BACKUP" > "$TARGET.tmp"
        echo "$CSS_CONTENT" >> "$TARGET.tmp"
    fi

    # Finalize
    mv "$TARGET.tmp" "$TARGET"
    chmod 644 "$TARGET"
    echo -e "${GREEN}   ✅ Success!${NC}"
done

echo -e "\n${GREEN}✨ All operations completed! Please restart Antigravity.${NC}"
