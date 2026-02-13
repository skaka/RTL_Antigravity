# 🌙 Antigravity Enhanced RTL Support
**[English](#english) | [العربية](#arabic)**

---

<a name="english"></a>
## 🇬🇧 English

This project provides a robust solution to enable **Smart Right-to-Left (RTL)** support for the Antigravity AI interface. It covers **Chat**, **Webviews**, and **Custom Editors** (Tasks, Implementation Plans), ensuring a consistent Arabic experience.

### ✨ v2.0 Features
- **Full UI Support**: Patches Chat, Webviews, and **Workflow Editors**.
- **List Fixes**: Force-enables RTL for `<ul>` and `<ol>` so bullets appear on the right.
- **Smart Text Direction**: Arabic text flows right-to-left, English flows left-to-right.
- **Better Typography**: Enforces `Cairo`, `Segoe UI`, or `Roboto`.
- **Code Logic Protection**: Code blocks (`pre`, `code`) remain strict LTR.
- **Safe Installation**: Auto-backup (`.bak`) for every modified file.

### 🚀 Installation

#### Method 1: One-Line Install (Recommended)
Clone and run:
```bash
git clone https://github.com/skaka/RTL_Antigravity.git
cd RTL_Antigravity
chmod +x install.sh
sudo ./install.sh
```

#### Method 2: Manual Check
The script searches for `cascade-panel.html`, `webview/.../index.html`, and `customEditor/.../*.css`.

### 🔄 Uninstallation (Restore)
To restore, rename the `.bak` files back to their original names in the respective directories.

---

<a name="arabic"></a>
## 🇸🇦 العربية

هذا المشروع يقدم حلاً شاملاً لتفعيل **دعم اللغة العربية (RTL)** في واجهة Antigravity AI. الآن يدعم **واجهة الدردشة**، **نوافذ شرح الملفات**، و **محررات المهام (Artifacts)**.

### ✨ مميزات الإصدار 2.0
- **إصلاح القوائم**: النقاط والأرقام تظهر الآن على اليمين بشكل صحيح.
- **دعم المحررات**: تحسين عرض ملفات `task.md` و `implementation_plan.md`.
- **توجيه ذكي للنصوص**: النصوص العربية من اليمين لليسار تلقائياً.
- **خطوط أفضل**: خطوط واضحة (`Cairo`, `Segoe UI`).
- **حماية الأكواد**: الأكواد البرمجية تبقى دائماً من اليسار لليمين (LTR).
- **تثبيت آمن**: نسخ احتياطية لكل ملف يتم تعديله.

### 🚀 التثبيت

#### الطريقة الأولى: التثبيت المباشر
حمل المستودع وشغل السكريبت:
```bash
git clone https://github.com/skaka/RTL_Antigravity.git
cd RTL_Antigravity
chmod +x install.sh
sudo ./install.sh
```

### 🔄 الاستعادة
لاستعادة النسخ الأصلية، قم بإعادة تسمية ملفات `.bak` إلى أسمائها الأصلية.
