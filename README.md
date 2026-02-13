# 🌙 Antigravity Enhanced RTL Support
**[English](#english) | [العربية](#arabic)**

---

<a name="english"></a>
## 🇬🇧 English

This project provides a robust solution to enable **Smart Right-to-Left (RTL)** support for the entire Antigravity AI interface. It covers **Chat**, **Artifact Viewer** (implementation plans, tasks, walkthroughs), and **Custom Editors**, ensuring a seamless Arabic experience everywhere.

### ✨ What's New in v3.1
- **📝 Chat Input Fix**: Input box now starts from Right-to-Left (RTL) by default, with cursor on the right.
- **🔢 List Alignment**: Bullets and numbers are now forced to the Right side (`direction: rtl`), fixing the logic where numbers appeared on the left.
- **🎯 Full Artifact Support**: `implementation_plan.md`, `task.md`, and `walkthrough.md` display Arabic text RTL automatically.
- **🧠 Smart Detection**: Uses `unicode-bidi: plaintext` for text content.
- **🔒 Code Protection**: Code blocks remain strict LTR.

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

### ✨ الجديد في الإصدار 3.1
- **📝 إصلاح مربع الإدخال**: المؤشر يبدأ الآن من اليمين (RTL) في خانة الدردشة.
- **🔢 محاذاة القوائم**: النقاط والأرقام تظهر الآن إجبارياً على اليمين.
- **🎯 دعم كامل للملفات**: `task.md` و `walkthrough.md` تظهر بشكل صحيح.
- **🧠 اكتشاف ذكي**: يستخدم `unicode-bidi: plaintext` للنصوص.
- **🔒 حماية الأكواد**: الأكواد البرمجية تبقى دائماً LTR.

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
