# 🌙 Antigravity Enhanced RTL Support
**[English](#english) | [العربية](#arabic)**

---

<a name="english"></a>
## 🇬🇧 English

This project provides a robust solution to enable **Smart Right-to-Left (RTL)** support for the Antigravity AI interface. It fixes Arabic text direction, improves fonts, and ensures code blocks remain readable (LTR).

### ✨ Features
- **Smart Text Direction**: Arabic text flows right-to-left, English flows left-to-right via `unicode-bidi: plaintext`.
- **Better Typography**: Enforces `Cairo`, `Segoe UI`, or `Roboto` for a modern look.
- **Code Logic Protection**: Code blocks (`pre`, `code`) are strictly kept LTR to prevent syntax confusion.
- **Safe Installation**: Automatically creates a backup (`.bak`) before applying changes.
- **Auto-Discovery**: Finds the installation path automatically on Linux.

### 🚀 Installation

#### Method 1: One-Line Install (Recommended)
You can run this directly from your terminal if you have `curl`:
```bash
# Clone and run (assuming you upload this repo)
git clone https://github.com/YOUR_USERNAME/antigravity-rtl-support.git
cd antigravity-rtl-support
chmod +x install.sh
sudo ./install.sh
```

#### Method 2: Manual Check
If the script doesn't find the path, run it with the explicit path:
```bash
sudo ./install.sh /path/to/antigravity/cascade-panel.html
```

### 🔄 Uninstallation (Restore)
To restore the original look, simply rename the backup file:
```bash
sudo mv /path/to/cascade-panel.html.bak /path/to/cascade-panel.html
```

---

<a name="arabic"></a>
## 🇸🇦 العربية

هذا المشروع يقدم حلاً قوياً لتفعيل **دعم اللغة العربية (RTL)** بشكل ذكي في واجهة Antigravity AI. يقوم بإصلاح اتجاه النصوص العربية، تحسين الخطوط، وضمان بقاء الأكواد البرمجية مقروءة (من اليسار لليمين).

### ✨ المميزات
- **توجيه ذكي للنصوص**: النصوص العربية تظهر من اليمين لليسار، والإنجليزية من اليسار لليمين تلقائياً.
- **خطوط أفضل**: استخدام خطوط حديثة مثل `Cairo` أو `Segoe UI` لقراءة مريحة.
- **حماية الأكواد**: الأكواد البرمجية (`pre`, `code`) تبقى دائماً من اليسار لليمين (LTR) لمنع تداخل الرموز.
- **تثبيت آمن**: يتم إنشاء نسخة احتياطية (`.bak`) تلقائياً قبل أي تعديل.
- **اكتشاف تلقائي**: يبحث السكريبت عن مسار التثبيت تلقائياً على أنظمة لينكس.

### 🚀 التثبيت

#### الطريقة الأولى: التثبيت المباشر (موصى به)
يمكنك تشغيل الأوامر التالية في التيرمينال:
```bash
# قم بتحميل المستودع وتشغيل التثبيت
git clone https://github.com/YOUR_USERNAME/antigravity-rtl-support.git
cd antigravity-rtl-support
chmod +x install.sh
sudo ./install.sh
```

#### الطريقة الثانية: التحديد اليدوي
إذا لم يجد السكريبت المسار تلقائياً، يمكنك تحديده يدوياً:
```bash
sudo ./install.sh /path/to/antigravity/cascade-panel.html
```

### 🔄 الاستعادة (إلغاء التثبيت)
لاستعادة الشكل الأصلي، ببساطة قم باسترجاع النسخة الاحتياطية التي تم إنشاؤها:
```bash
sudo mv /path/to/cascade-panel.html.bak /path/to/cascade-panel.html
```
