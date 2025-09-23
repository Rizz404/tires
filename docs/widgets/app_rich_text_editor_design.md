# AppRichTextEditor - Design & Behavior Guide

## UI States

### 1. **Collapsed State (Default)**
```
┌─────────────────────────────────────────────────────┐
│ 🎨 Formatting Tools  B I • 🔗         ▼           │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Enter your content here...                          │
│                                                     │
│                                                     │
│                                                     │
└─────────────────────────────────────────────────────┘
```
- Toolbar tersembunyi secara default
- Tampilan bersih dan compact
- Mini format indicators menunjukkan tools yang tersedia
- Arrow down menunjukkan toolbar dapat di-expand

### 2. **Expanded State (When Needed)**
```
┌─────────────────────────────────────────────────────┐
│ 🎨 Formatting Tools                        ▲        │
├─────────────────────────────────────────────────────┤
│ B I U | H₁ H₂ H₃ | • 1 | " | ↶ ↷ | 🔗 | ✨ | ⇥   │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Enter your content here...                          │
│                                                     │
│                                                     │
│                                                     │
└─────────────────────────────────────────────────────┘
```
- Full toolbar dengan semua formatting options
- Arrow up menunjukkan toolbar dapat di-collapse
- Smooth animation saat transition

### 3. **Focus State**
```
┌─────────────────────────────────────────────────────┐
│ 🎨 Formatting Tools                        ▲        │  ← Auto-expanded
├─────────────────────────────────────────────────────┤
│ B I U | H₁ H₂ H₃ | • 1 | " | ↶ ↷ | 🔗 | ✨ | ⇥   │
├─────────────────────────────────────────────────────┤
│ |                                                   │  ← Cursor visible
│ Your content with **bold** and *italic* text       │
│                                                     │
│                                                     │
│                                                     │
└─────────────────────────────────────────────────────┘
```
- Toolbar otomatis muncul saat editor mendapat focus
- User dapat langsung menggunakan formatting tools

## Interaction Behaviors

### **Toggle Toolbar**
- **Click arrow button** → Toggle show/hide toolbar
- **Click mini format buttons** → Auto-expand toolbar
- **Focus on editor** → Auto-expand toolbar
- **Animation duration**: 200ms untuk smooth transition

### **Smart Design**
1. **Default State**: Toolbar tersembunyi untuk UI yang bersih
2. **On Focus**: Toolbar otomatis muncul untuk akses mudah ke tools
3. **Manual Toggle**: User bisa manually show/hide kapan saja
4. **Mini Preview**: Saat collapsed, tetap show hint formatting yang tersedia

## Benefits

✅ **Clean Interface** - Tidak overwhelming dengan terlalu banyak buttons
✅ **Progressive Disclosure** - Tools muncul saat dibutuhkan
✅ **Better UX** - Fokus pada content, tools sebagai secondary
✅ **Space Efficient** - Menghemat vertical space di form
✅ **Intuitive** - Behavior yang predictable dan user-friendly

## Technical Implementation

- ✅ **AnimatedContainer** untuk smooth height transitions
- ✅ **AnimatedOpacity** untuk fade in/out effects
- ✅ **FocusNode listener** untuk auto-expand behavior
- ✅ **State management** untuk toolbar visibility
- ✅ **Responsive design** yang beradaptasi dengan container size
