#!/bin/bash
# -----------------------------------------------------------------------------
# Antigravity Enhanced RTL Support v3.0
# -----------------------------------------------------------------------------
# Description: Automatically enables smart Right-to-Left (RTL) support for
#              the entire Antigravity AI interface: Chat, Webviews (Artifacts
#              like implementation_plan.md, task.md, walkthrough.md), and
#              Custom Editors (Workflow/Rule Editors).
# Author:      Antigravity Community
# License:     MIT
# Version:     3.0
# -----------------------------------------------------------------------------

# set -e  <-- Disabled to prevent premature exit on grep/diff

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

VERSION="3.0"
PATCH_MARKER="Smart RTL Support v3"

# --- Uninstall Mode ---
if [ "$1" = "--uninstall" ] || [ "$1" = "-u" ]; then
    echo -e "${YELLOW}🔄 Uninstalling RTL Support — Restoring backups...${NC}"
    TARGETS=(
        "/usr/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
        "/opt/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
        "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
        "/usr/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
        "/opt/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
        "$HOME/.local/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
        "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
        "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
        "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
        "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
        "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
        "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
    )
    RESTORED=0
    for path in "${TARGETS[@]}"; do
        if [ -f "${path}.bak" ]; then
            echo -e "${BLUE}   Restoring: $path${NC}"
            cp "${path}.bak" "$path"
            ((RESTORED++))
        fi
    done
    if [ $RESTORED -eq 0 ]; then
        echo -e "${RED}❌ No backup files found. Nothing to restore.${NC}"
    else
        echo -e "${GREEN}✅ Restored $RESTORED file(s). Please restart Antigravity.${NC}"
    fi
    exit 0
fi

echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   🚀 Antigravity RTL Support Patcher v${VERSION}          ║${NC}"
echo -e "${CYAN}║   Full support: Chat + Artifacts + Editors          ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# --- 1. Define Targets ---
TARGETS=(
    # Chat Interface
    "/usr/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "/opt/antigravity/resources/app/extensions/antigravity/cascade-panel.html"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/cascade-panel.html"

    # Webview / Artifact Viewer (implementation_plan.md, task.md, walkthrough.md)
    "/usr/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "/opt/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"
    "$HOME/.local/share/antigravity/resources/app/out/vs/workbench/contrib/webview/browser/pre/index.html"

    # Workflow Editor (task.md, implementation_plan.md editing) - CSS
    "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
    "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/workflowEditor/workflowEditor.css"

    # Rule Editor - CSS
    "/usr/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
    "/opt/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
    "$HOME/.local/share/antigravity/resources/app/extensions/antigravity/customEditor/media/ruleEditor/ruleEditor.css"
)

# Detect existing files
FOUND_TARGETS=()
for path in "${TARGETS[@]}"; do
    if [ -f "$path" ]; then
        FOUND_TARGETS+=("$path")
    fi
done

if [ ${#FOUND_TARGETS[@]} -eq 0 ]; then
    echo -e "${RED}❌ Error: Could not find any Antigravity interface files.${NC}"
    echo -e "${YELLOW}Checked paths under: /usr/share/, /opt/, ~/.local/share/${NC}"
    exit 1
fi

echo -e "${BLUE}🔍 Found ${#FOUND_TARGETS[@]} target(s) to patch:${NC}"
for t in "${FOUND_TARGETS[@]}"; do
    echo -e "   ${CYAN}→${NC} $t"
done
echo ""

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

# --- 3. CSS Payloads ---

# Core RTL CSS — uses unicode-bidi: plaintext for auto-detection
CSS_CORE='
/* --- Smart RTL Support v3 by Antigravity Community --- */
/* Auto-detects text direction: Arabic=RTL, English=LTR, Code=LTR */

/* 1. Base: Auto-detect direction for all text elements */
body, p, h1, h2, h3, h4, h5, h6, span, div, section, article,
td, th, caption, figcaption, blockquote, details, summary,
.markdown-body, .rendered-markdown,
.react-app-container, .monaco-editor .view-line,
.workflow-editor, .rule-editor {
    unicode-bidi: plaintext !important;
    text-align: start !important;
    line-height: 1.7 !important;
}

/* 2. Lists: auto-detect direction per-item */
ul, ol {
    unicode-bidi: plaintext !important;
    text-align: start !important;
    padding-inline-start: 25px !important;
}
li {
    unicode-bidi: plaintext !important;
    text-align: start !important;
    list-style-position: outside !important;
}

/* 3. Code blocks: ALWAYS LTR (protected) */
pre, code, .code-block, .monaco-editor .view-lines,
textarea.code, kbd, samp, var {
    direction: ltr !important;
    unicode-bidi: normal !important;
    text-align: left !important;
    font-family: "Fira Code", "Consolas", "Monaco", monospace !important;
}

/* 4. Tables: auto-detect per cell */
table {
    unicode-bidi: plaintext !important;
}
th, td {
    unicode-bidi: plaintext !important;
    text-align: start !important;
}

/* 5. Input fields: auto-detect direction */
input[type="text"], textarea {
    unicode-bidi: plaintext !important;
    text-align: start !important;
}

/* 6. Typography enhancement */
body {
    font-family: "Cairo", "Segoe UI", "Roboto", system-ui, sans-serif !important;
}

/* 7. Alerts/Blockquotes: proper padding */
blockquote {
    padding-inline-start: 1em !important;
    padding-inline-end: 0 !important;
    border-inline-start: 4px solid var(--vscode-textBlockQuote-border, #007acc) !important;
    border-inline-end: none !important;
}
/* --- End Smart RTL Support v3 --- */
'

# HTML wrapper
HTML_PAYLOAD="<style>${CSS_CORE}</style>"

# CSS wrapper (direct append)
CSS_PAYLOAD="${CSS_CORE}"

# --- 4. Loop & Patch ---
PATCHED=0
SKIPPED=0
FAILED=0

for TARGET in "${FOUND_TARGETS[@]}"; do
    echo -e "${BLUE}🛠  Processing: $(basename "$TARGET")${NC}"
    echo -e "   ${CYAN}Path: $TARGET${NC}"

    # Idempotency: Check for v3 marker
    if grep -q "$PATCH_MARKER" "$TARGET" 2>/dev/null; then
        echo -e "${GREEN}   ✅ Already patched (v3).${NC}"
        ((SKIPPED++))
        continue
    fi

    # Remove old v1/v2 patch if present (clean upgrade)
    if grep -q "Smart RTL Support" "$TARGET" 2>/dev/null; then
        echo -e "${YELLOW}   🔄 Found old patch, will upgrade to v3...${NC}"
        # Restore from backup first if available
        if [ -f "${TARGET}.bak" ]; then
            cp "${TARGET}.bak" "$TARGET"
        fi
    fi

    # Backup
    BACKUP="${TARGET}.bak"
    if [ ! -f "$BACKUP" ]; then
        echo -e "${YELLOW}   📦 Creating backup: $(basename "$BACKUP")${NC}"
        cp "$TARGET" "$BACKUP"
    fi

    echo -e "${YELLOW}   💉 Injecting RTL styles (v3)...${NC}"

    # Determine file type and inject
    if [[ "$TARGET" == *.html ]]; then
        # HTML: inject before </head>
        if grep -q "</head>" "$TARGET"; then
            awk -v css="$HTML_PAYLOAD" '/<\/head>/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
        elif grep -q "<body" "$TARGET"; then
            awk -v css="<head>$HTML_PAYLOAD</head>" '/<body/ { print css } { print }' "$BACKUP" > "$TARGET.tmp"
        else
            cat "$BACKUP" > "$TARGET.tmp"
            echo "$HTML_PAYLOAD" >> "$TARGET.tmp"
        fi
    elif [[ "$TARGET" == *.css ]]; then
        # CSS: append at end
        cat "$BACKUP" > "$TARGET.tmp"
        echo "" >> "$TARGET.tmp"
        echo "$CSS_PAYLOAD" >> "$TARGET.tmp"
    fi

    # Verify injection worked
    if grep -q "$PATCH_MARKER" "$TARGET.tmp" 2>/dev/null; then
        mv "$TARGET.tmp" "$TARGET"
        chmod 644 "$TARGET"
        echo -e "${GREEN}   ✅ Patched successfully!${NC}"
        ((PATCHED++))
    else
        rm -f "$TARGET.tmp"
        echo -e "${RED}   ❌ Failed to patch!${NC}"
        ((FAILED++))
    fi

    echo ""
done

# --- 5. Summary ---
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                    📊 Summary                       ║${NC}"
echo -e "${CYAN}╠══════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✅ Patched:  $PATCHED${NC}"
echo -e "${CYAN}║${NC}  ${YELLOW}⏭  Skipped:  $SKIPPED (already v3)${NC}"
echo -e "${CYAN}║${NC}  ${RED}❌ Failed:   $FAILED${NC}"
echo -e "${CYAN}╠══════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  To uninstall: ${BLUE}sudo ./install.sh --uninstall${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

if [ $FAILED -gt 0 ]; then
    echo -e "${RED}⚠  Some files failed to patch. Check permissions.${NC}"
    exit 1
fi

echo -e "${GREEN}✨ Done! Please restart Antigravity to see the changes.${NC}"
