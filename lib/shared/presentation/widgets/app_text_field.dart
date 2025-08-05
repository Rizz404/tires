import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum AppTextFieldType { email, password, text }

class AppTextField extends StatefulWidget {
  final String name;
  final String label;
  final String? placeHolder;
  final AppTextFieldType type;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.name,
    required this.label,
    this.placeHolder,
    this.type = AppTextFieldType.text,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      obscureText: widget.type == AppTextFieldType.password
          ? _obscureText
          : false,
      keyboardType: widget.type == AppTextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeHolder,
        suffixIcon: widget.type == AppTextFieldType.password
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
