#!/bin/bash
# -----------------------------------------------------------------------------
# Antigravity Enhanced RTL Support
# -----------------------------------------------------------------------------
# Description: Automatically enables smart Right-to-Left (RTL) support for 
#              Antigravity AI interface, improving Arabic font rendering and 
#              text direction while preserving code blocks.
# Author:      Antigravity Community
# License:     MIT
# -----------------------------------------------------------------------------

set -e

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Enhanced RTL Support Patcher...${NC}"

# --- 1. Define Potential Paths ---
POSSIBLE_PATHS=(
    "/usr/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html" # Linux Standard
    "/opt/antigravity/resources/app/extensions/antigravity/cascade-panel.html"       # Linux Opt
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html" # Linux User
    # Add Windows/Mac paths if needed in future
)

TARGET=""

# --- 2. Auto-Discovery ---
echo "🔍 Searching for cascade-panel.html..."
for path in "${POSSIBLE_PATHS[@]}"; do
    if [ -f "$path" ]; then
        TARGET="$path"
        echo -e "${GREEN}✅ Found: $TARGET${NC}"
        break
    fi
done

if [ -z "$TARGET" ]; then
    echo -e "${RED}❌ Error: Could not find cascade-panel.html in standard locations.${NC}"
    echo "   Please try running this script with the file path as an argument:"
    echo "   Usage: sudo ./install.sh /path/to/cascade-panel.html"
    exit 1
fi

# --- 3. Permission Check ---
if [ ! -w "$TARGET" ] && [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}🔒 File is protected. Attempting to switch to sudo...${NC}"
    exec sudo "$0" "$@"
fi

# --- 4. Idempotency Check ---
if grep -q "Smart RTL Support" "$TARGET"; then
    echo -e "${GREEN}✅ System is already patched! No changes needed.${NC}"
    exit 0
fi

# --- 5. Backup ---
BACKUP="${TARGET}.bak"
echo -e "${YELLOW}📦 Creating backup: $BACKUP${NC}"
cp "$TARGET" "$BACKUP"

# --- 6. The Payload (CSS) ---
CSS_CONTENT='
<style>
/* --- Smart RTL Support by Antigravity Community --- */
/* 1. Content-Aware Directionality */
.react-app-container, .markdown-body, .monaco-editor .view-line, p, h1, h2, h3, h4, li {
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

# --- 7. Injection Logic ---
echo -e "${YELLOW}💉 Injecting RTL styles...${NC}"

if grep -q "<\/head>" "$TARGET"; then
    awk -v css="$CSS_CONTENT" '/<\/head>/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
elif grep -q "<body" "$TARGET"; then
    # Missing head tag? Inject wrapped in head before body
    awk -v css="<head>$CSS_CONTENT</head>" '/<body/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
else
    # Fallback
    cat "$BACKUP" > "$TARGET.tmp"
    echo "$CSS_CONTENT" >> "$TARGET.tmp"
fi

# --- 8. Finalize ---
mv "$TARGET.tmp" "$TARGET"
chmod 644 "$TARGET"

echo -e "${GREEN}✅ Success! Patch applied.${NC}" 
echo -e "${GREEN}🔄 Please restart Antigravity to see the changes.${NC}"
