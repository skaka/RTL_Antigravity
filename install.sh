#!/bin/bash
# -----------------------------------------------------------------------------
# Antigravity Enhanced RTL Support
# -----------------------------------------------------------------------------
# Description: Automatically enables smart Right-to-Left (RTL) support for 
#              Antigravity AI interface (Chat, Webviews, & Editors).
#              Now fixes lists (bullets) and custom artifacts styling.
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

echo -e "${GREEN}🚀 Starting Enhanced RTL Support Patcher v2.0...${NC}"

# --- 1. Define Targets ---
# We now target multiple file types:
# - HTML: Chat Interface & Webviews
# - CSS: Custom Editors (Workflow/Rules) to fix artifacts

TARGETS=(
    # Chat Interface
    "/usr/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "/opt/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    
    # Webview / File Explanation Container
    "/usr/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "/opt/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "$HOME/.local/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"

    # Workflow Editor (Tasks, Implementation Plans) - CSS
    "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
    "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"

    # Rule Editor - CSS
    "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
    "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
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
    exit 1
fi

echo -e "${BLUE}🔍 Found ${#FOUND_TARGETS[@]} target(s) to patch:${NC}"
for t in "${FOUND_TARGETS[@]}"; do
    echo "   - $t"
done

# --- 2. Permission Check ---
NEED_SUDO=false
for t in "${FOUND_TARGETS[@]}"; do
    if [ ! -w "$t" ]; then
        NEED_SUDO=true
        break
    fi
done

if [ "$NEED_SUDO" = true ] && [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}🔒 Switching to sudo for system file modification...${NC}"
    exec sudo "$0" "$@"
fi

# --- 3. The Payload (CSS) ---

# Core RTL CSS (Shared)
CSS_CORE='
/* --- Smart RTL Support by Antigravity Community --- */
/* 1. Content-Aware Directionality */
.react-app-container, .markdown-body, .monaco-editor .view-line, p, h1, h2, h3, h4, 
.workflow-editor, .rule-editor, body {
    unicode-bidi: plaintext !important;
    text-align: start !important;
    line-height: 1.6 !important;
    font-family: "Segoe UI", "Roboto", "Cairo", sans-serif !important;
}

/* 2. List Fixes (Bullets on Right) */
ul, ol { 
    direction: rtl !important; 
    text-align: right !important; 
    padding-inline-start: 25px !important; 
}
li { 
    unicode-bidi: plaintext !important; 
    list-style-position: outside !important;
}

/* 3. Code Block Protection (Strict LTR) */
pre, code, .code-block, .monaco-editor .view-lines, textarea {
    direction: ltr !important;
    unicode-bidi: normal !important;
    text-align: left !important;
    font-family: "Fira Code", "Consolas", monospace !important;
}

/* 4. Input Fields Fix */
input[type="text"] {
    direction: auto !important;
    text-align: start !important;
}
'

# Wrapper for HTML files
HTML_PAYLOAD="<style>${CSS_CORE}</style>"

# Wrapper for CSS files (Direct append)
CSS_PAYLOAD="${CSS_CORE}"

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

    echo -e "${YELLOW}   💉 Injecting RTL styles...${NC}"

    # Determine file type
    if [[ "$TARGET" == *.html ]]; then
        # HTML Injection Strategy
        if grep -q "<\/head>" "$TARGET"; then
            awk -v css="$HTML_PAYLOAD" '/<\/head>/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
        elif grep -q "<body" "$TARGET"; then
            awk -v css="<head>$HTML_PAYLOAD</head>" '/<body/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
        else
            cat "$BACKUP" > "$TARGET.tmp"
            echo "$HTML_PAYLOAD" >> "$TARGET.tmp"
        fi
    elif [[ "$TARGET" == *.css ]]; then
        # CSS Append Strategy
        cat "$BACKUP" > "$TARGET.tmp"
        echo "$CSS_PAYLOAD" >> "$TARGET.tmp"
    fi

    # Finalize
    mv "$TARGET.tmp" "$TARGET"
    chmod 644 "$TARGET"
    echo -e "${GREEN}   ✅ Success!${NC}"
done

echo -e "\n${GREEN}✨ All operations completed! Please restart Antigravity.${NC}"
