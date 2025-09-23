import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/shared/presentation/widgets/app_rich_text_editor.dart';

class ExampleRichTextEditorForm extends StatefulWidget {
  const ExampleRichTextEditorForm({super.key});

  @override
  State<ExampleRichTextEditorForm> createState() =>
      _ExampleRichTextEditorFormState();
}

class _ExampleRichTextEditorFormState extends State<ExampleRichTextEditorForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rich Text Editor Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              // Rich Text Editor using flutter_quill
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
              const SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final formData = _formKey.currentState!.value;

                    // Show the rich text content
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Form Data'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(formData['description'] ?? 'No content'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
