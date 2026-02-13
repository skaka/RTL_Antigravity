# 🌙 Antigravity Enhanced RTL Support
**[English](#english) | [العربية](#arabic)**

---

<a name="english"></a>
## 🇬🇧 English

This project provides a robust solution to enable **Smart Right-to-Left (RTL)** support for the entire Antigravity AI interface. It covers **Chat**, **Artifact Viewer** (implementation plans, tasks, walkthroughs), and **Custom Editors**, ensuring a seamless Arabic experience everywhere.

### ✨ What's New in v3.0
- **🎯 Full Artifact Support**: Patches the **Webview renderer** (`index.html`) so `implementation_plan.md`, `task.md`, and `walkthrough.md` display Arabic text RTL automatically.
- **📝 Editor Support**: Patches `workflowEditor.css` and `ruleEditor.css` for proper RTL in editing mode.
- **🧠 Smart Detection**: Uses `unicode-bidi: plaintext` — the browser auto-detects text direction per paragraph (Arabic=RTL, English=LTR, Code=LTR).
- **📋 Table & List Fixes**: Tables and lists respect text direction per-cell/per-item.
- **🔒 Code Protection**: Code blocks, `<pre>`, `<code>` remain strict LTR always.
- **↩️ Uninstall Support**: Run `--uninstall` to restore original files from backups.
- **🔄 Clean Upgrade**: Automatically removes old v1/v2 patches before applying v3.

### 📦 Files Patched
| File | Purpose |
|---|---|
| `cascade-panel.html` | Chat interface |
| `webview/.../index.html` | Artifact viewer (markdown rendering) |
| `workflowEditor.css` | Task/workflow editor |
| `ruleEditor.css` | Rule editor |

### 🚀 Installation

```bash
git clone https://github.com/skaka/RTL_Antigravity.git
cd RTL_Antigravity
chmod +x install.sh
sudo ./install.sh
```

### 🔄 Uninstallation

To restore original files:
```bash
sudo ./install.sh --uninstall
```

Then restart Antigravity.

---

<a name="arabic"></a>
## 🇸🇦 العربية

هذا المشروع يقدم حلاً شاملاً لتفعيل **دعم اللغة العربية (RTL)** في كامل واجهة Antigravity AI — **الدردشة**، **نوافذ عرض الملفات** (implementation_plan, task, walkthrough)، و **محررات المهام**.

### ✨ الجديد في الإصدار 3.0
- **🎯 دعم كامل للملفات**: الآن ملفات `implementation_plan.md` و `task.md` و `walkthrough.md` تعرض النص العربي من اليمين لليسار **تلقائياً**.
- **🧠 اكتشاف ذكي**: يستخدم `unicode-bidi: plaintext` — المتصفح يكتشف اتجاه النص تلقائياً لكل فقرة.
- **📋 إصلاح الجداول والقوائم**: الجداول والقوائم تحترم اتجاه النص في كل خلية/عنصر.
- **🔒 حماية الأكواد**: الأكواد البرمجية تبقى دائماً من اليسار لليمين (LTR).
- **↩️ إلغاء التثبيت**: شغّل `--uninstall` لاستعادة الملفات الأصلية.
- **🔄 ترقية نظيفة**: يزيل الإصدارات القديمة (v1/v2) تلقائياً قبل تطبيق v3.

### 📦 الملفات المعدّلة
| الملف | الوظيفة |
|---|---|
| `cascade-panel.html` | واجهة الدردشة |
| `webview/.../index.html` | عارض الملفات (Markdown) |
| `workflowEditor.css` | محرر المهام |
| `ruleEditor.css` | محرر القواعد |

### 🚀 التثبيت

```bash
git clone https://github.com/skaka/RTL_Antigravity.git
cd RTL_Antigravity
chmod +x install.sh
sudo ./install.sh
```

### 🔄 إلغاء التثبيت

لاستعادة الملفات الأصلية:
```bash
sudo ./install.sh --uninstall
```

ثم أعد تشغيل Antigravity.

---

### 📄 License
MIT — Free for everyone 🌍
