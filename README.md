# 🌙 Antigravity Enhanced RTL Support
**[English](#english) | [العربية](#arabic)**

---

<a name="english"></a>
## 🇬🇧 English

This project provides a robust solution to enable **Smart Right-to-Left (RTL)** support for the Antigravity AI interface. It now covers both the **Chat Interface** and **File Explanations/Webviews**, ensuring a consistent Arabic experience throughout the IDE.

### ✨ Features
- **Full UI Support**: Patches both Chat and Webviews (Artifacts, Markdown previews, etc.).
- **Smart Text Direction**: Arabic text flows right-to-left, English flows left-to-right via `unicode-bidi: plaintext`.
- **Better Typography**: Enforces `Cairo`, `Segoe UI`, or `Roboto`.
- **Code Logic Protection**: Code blocks (`pre`, `code`) remain strict LTR.
- **Safe Installation**: Auto-backup (`.bak`) for every modified file.
- **Auto-Discovery**: Finds installation paths automatically.

### 🚀 Installation

#### Method 1: One-Line Install (Recommended)
Clone and run:
```bash
git clone https://github.com/YOUR_USERNAME/antigravity-rtl-support.git
cd antigravity-rtl-support
chmod +x install.sh
sudo ./install.sh
```

#### Method 2: Manual Check
The script searches for `cascade-panel.html` and `webview/.../index.html`. If not found, you can manually edit the `TARGETS` array in the script.

### 🔄 Uninstallation (Restore)
To restore, rename the `.bak` files back to their original names in the respective directories.

---

<a name="arabic"></a>
## 🇸🇦 العربية

هذا المشروع يقدم حلاً شاملاً لتفعيل **دعم اللغة العربية (RTL)** في واجهة Antigravity AI. الآن يدعم **واجهة الدردشة** و **نوافذ شرح الملفات (Webviews)**، مما يضمن تجربة عربية متناسقة في كامل المحرر.

### ✨ المميزات
- **دعم شامل للواجهة**: يشمل التعديل واجهة الشات ونوافذ عرض الملفات (Markdown, Artifacts).
- **توجيه ذكي للنصوص**: النصوص العربية تظهر من اليمين لليسار تلقائياً.
- **خطوط أفضل**: تحسين الخطوط لتكون أكثر وضوحاً (`Cairo`, `Segoe UI`).
- **حماية الأكواد**: الأكواد البرمجية تبقى دائماً من اليسار لليمين (LTR).
- **تثبيت آمن**: يتم أخذ نسخ احتياطية لكل ملف يتم تعديله.
- **اكتشاف تلقائي**: يبحث السكريبت عن الملفات المطلوبة ويعدلها تلقائياً.

### 🚀 التثبيت

#### الطريقة الأولى: التثبيت المباشر
حمل المستودع وشغل السكريبت:
```bash
git clone https://github.com/YOUR_USERNAME/antigravity-rtl-support.git
cd antigravity-rtl-support
chmod +x install.sh
sudo ./install.sh
```

### 🔄 الاستعادة
لاستعادة النسخ الأصلية، قم بإعادة تسمية ملفات `.bak` إلى أسمائها الأصلية في المسارات المعدلة.
