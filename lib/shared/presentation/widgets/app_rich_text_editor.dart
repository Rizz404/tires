import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';

class AppRichTextEditor extends StatefulWidget {
  final String name;
  final String label;
  final String? initialValue;
  final String? Function(String?)? validator;

  const AppRichTextEditor({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.validator,
  });

  @override
  State<AppRichTextEditor> createState() => _AppRichTextEditorState();
}

class _AppRichTextEditorState extends State<AppRichTextEditor> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();
  bool _isBold = false;
  bool _isItalic = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _insertHtmlTag(String openTag, String closeTag) {
    final text = _controller.text;
    final selection = _controller.selection;

    if (selection.isValid) {
      final selectedText = text.substring(selection.start, selection.end);
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        '$openTag$selectedText$closeTag',
      );

      _controller.text = newText;
      _controller.selection = TextSelection.collapsed(
        offset:
            selection.start +
            openTag.length +
            selectedText.length +
            closeTag.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (FormFieldState<String> field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            errorText: field.errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Simple toolbar with basic formatting buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.format_bold,
                        color: _isBold
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        _toggleBold();
                        _insertHtmlTag('<b>', '</b>');
                      },
                      tooltip: 'Bold',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_italic,
                        color: _isItalic
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        _toggleItalic();
                        _insertHtmlTag('<i>', '</i>');
                      },
                      tooltip: 'Italic',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: context.colorScheme.onSurface,
                      ),
                      onPressed: () => _insertHtmlTag('<ul><li>', '</li></ul>'),
                      tooltip: 'Bullet List',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.link,
                        color: context.colorScheme.onSurface,
                      ),
                      onPressed: () => _insertHtmlTag('<a href="">', '</a>'),
                      tooltip: 'Link',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Text editor
              SizedBox(
                height: 200,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    hintText: 'Enter your content here...',
                  ),
                  onChanged: (value) {
                    field.didChange(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
