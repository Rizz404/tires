import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
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
  late QuillController _quillController;
  final _focusNode = FocusNode();
  bool _isToolbarVisible = false; // Add toolbar visibility state

  @override
  void initState() {
    super.initState();
    // Initialize QuillController with initial value
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      try {
        // Try to parse as HTML or just use as plain text
        final document = Document()..insert(0, widget.initialValue!);
        _quillController = QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        // If parsing fails, create basic controller
        _quillController = QuillController.basic();
      }
    } else {
      _quillController = QuillController.basic();
    }

    // Listen to document changes
    _quillController.addListener(_onQuillContentChanged);

    // Show toolbar when editor gets focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_isToolbarVisible) {
        setState(() {
          _isToolbarVisible = true;
        });
      }
    });
  }

  void _onQuillContentChanged() {
    // This will be called when the content changes
    // We'll trigger the form field update in the widget build
  }

  void _toggleToolbar() {
    setState(() {
      _isToolbarVisible = !_isToolbarVisible;
    });
  }

  @override
  void dispose() {
    _quillController.removeListener(_onQuillContentChanged);
    _quillController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _getQuillContentAsString() {
    // Get plain text content from QuillController
    return _quillController.document.toPlainText();
  }

  Widget _buildMiniFormatButton(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: () {
          // Auto-expand toolbar when mini button is tapped
          if (!_isToolbarVisible) {
            _toggleToolbar();
          }
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 14,
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (FormFieldState<String> field) {
        // Listen to changes and update field
        void onDocumentChanged() {
          final content = _getQuillContentAsString();
          field.didChange(content);
        }

        // Remove previous listener and add new one
        _quillController.removeListener(onDocumentChanged);
        _quillController.addListener(onDocumentChanged);

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
              // Compact header with toggle button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: context.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.format_paint,
                        size: 16,
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Formatting Tools',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Show basic formatting indicators when toolbar is hidden
                      if (!_isToolbarVisible) ...[
                        _buildMiniFormatButton(Icons.format_bold, 'Bold'),
                        _buildMiniFormatButton(Icons.format_italic, 'Italic'),
                        _buildMiniFormatButton(
                          Icons.format_list_bulleted,
                          'List',
                        ),
                        _buildMiniFormatButton(Icons.link, 'Link'),
                      ],
                      IconButton(
                        icon: Icon(
                          _isToolbarVisible
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 18,
                          color: context.colorScheme.primary,
                        ),
                        onPressed: _toggleToolbar,
                        tooltip: _isToolbarVisible
                            ? 'Hide toolbar'
                            : 'Show toolbar',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Animated toolbar section
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: _isToolbarVisible ? null : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isToolbarVisible ? 1.0 : 0.0,
                  child: _isToolbarVisible
                      ? Container(
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: context.colorScheme.outline.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: QuillSimpleToolbar(
                            controller: _quillController,
                            config: const QuillSimpleToolbarConfig(
                              showBoldButton: true,
                              showItalicButton: true,
                              showUnderLineButton: true,
                              showStrikeThrough: false,
                              showInlineCode: true,
                              showColorButton: false,
                              showBackgroundColorButton: false,
                              showClearFormat: true,
                              showAlignmentButtons: false,
                              showLeftAlignment: false,
                              showCenterAlignment: false,
                              showRightAlignment: false,
                              showJustifyAlignment: false,
                              showHeaderStyle: true,
                              showListNumbers: true,
                              showListBullets: true,
                              showListCheck: false,
                              showCodeBlock: false,
                              showQuote: true,
                              showIndent: true,
                              showLink: true,
                              showClipboardCut: false,
                              showClipboardCopy: false,
                              showClipboardPaste: false,
                              showRedo: true,
                              showUndo: true,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 8),
              // QuillEditor for rich text editing
              SizedBox(
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.outline.withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: QuillEditor.basic(
                    controller: _quillController,
                    focusNode: _focusNode,
                    config: const QuillEditorConfig(
                      padding: EdgeInsets.all(12),
                      placeholder: 'Enter your content here...',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
