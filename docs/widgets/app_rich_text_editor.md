# AppRichTextEditor - Flutter Quill Rich Text Editor

## Overview
`AppRichTextEditor` adalah widget rich text editor yang menggunakan `flutter_quill` package dengan integrasi `FormBuilder` untuk konsistensi dengan form-form lain di aplikasi.

## Features
- ✅ **Rich Text Editing** menggunakan flutter_quill
- ✅ **FormBuilder Integration** untuk konsistensi dengan form lain
- ✅ **Collapsible Toolbar** - toolbar dapat disembunyikan/ditampilkan
- ✅ **Auto-expand** - toolbar otomatis muncul saat editor di-focus
- ✅ **Mini Format Indicators** - preview format tools saat toolbar tersembunyi
- ✅ **Smooth Animations** - transisi yang halus saat toggle toolbar
- ✅ **Validation Support** dengan custom validator
- ✅ **Initial Value Support** untuk editing konten yang sudah ada

## Toolbar Features
- **Bold**, **Italic**, **Underline** text formatting
- **Headers** (H1, H2, H3, etc.)
- **Lists** (Bullet points dan numbered lists)
- **Quotes** dan **Code blocks**
- **Links** insertion
- **Undo/Redo** functionality
- **Clear formatting**
- **Text indentation**

## UI/UX Improvements
- **Clean Design** - toolbar tersembunyi secara default untuk tampilan yang bersih
- **Smart Toggle** - klik pada mini format button akan otomatis expand toolbar
- **Focus Behavior** - toolbar otomatis muncul saat editor mendapat focus
- **Visual Feedback** - animasi smooth untuk pengalaman pengguna yang baik

## Usage

### Basic Usage
```dart
AppRichTextEditor(
  name: 'description',
  label: 'Product Description',
  initialValue: 'Initial content here...',
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  },
)
```

### Complete Form Example
```dart
FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      AppRichTextEditor(
        name: 'description',
        label: 'Product Description',
        initialValue: 'Enter your product description here...',
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Description is required';
          }
          if (value.trim().length < 10) {
            return 'Description must be at least 10 characters';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            final formData = _formKey.currentState!.value;
            final description = formData['description']; // Gets plain text content
            // Process the form data...
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

## Properties

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | `String` | ✅ | Nama field untuk FormBuilder |
| `label` | `String` | ✅ | Label yang ditampilkan di atas editor |
| `initialValue` | `String?` | ❌ | Konten awal editor (plain text) |
| `validator` | `String? Function(String?)?` | ❌ | Fungsi validasi untuk field |

## Important Notes

1. **Output Format**: Widget ini mengembalikan **plain text** dari QuillController. Jika Anda perlu format yang lebih kaya (HTML/JSON), widget dapat dimodifikasi untuk mengembalikan format lain.

2. **FormBuilder Integration**: Widget ini fully compatible dengan `flutter_form_builder` sehingga bisa digunakan bersama dengan field-field form lain dengan konsisten.

3. **Height**: Editor memiliki height tetap 200px. Jika perlu responsive height, dapat dimodifikasi.

4. **Toolbar Configuration**: Toolbar sudah dikonfigurasi dengan fitur-fitur yang umum digunakan. Jika perlu kustomisasi lebih lanjut, dapat memodifikasi `QuillSimpleToolbarConfig`.

## Migration from Old Version

Jika sebelumnya menggunakan `TextField` biasa dengan HTML tags manual:

**Before:**
```dart
TextField(
  controller: _controller,
  onChanged: (value) => field.didChange(value),
  // Manual HTML tag insertion...
)
```

**After:**
```dart
AppRichTextEditor(
  name: 'description',
  label: 'Description',
  validator: (value) => // validation logic
)
```

## Dependencies

Pastikan `flutter_quill` sudah ditambahkan di `pubspec.yaml`:

```yaml
dependencies:
  flutter_quill: ^11.4.2  # or latest version
```
