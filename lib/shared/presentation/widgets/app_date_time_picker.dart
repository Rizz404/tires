import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppDateTimePicker extends StatelessWidget {
  final String name;
  final String label;
  final InputType inputType;
  final IconData? icon;
  final String? Function(DateTime?)? validator;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppDateTimePicker({
    super.key,
    required this.name,
    required this.label,
    this.inputType = InputType.date,
    this.icon,
    this.validator,
    this.initialValue,
    this.firstDate,
    this.lastDate,
  });

  IconData get _defaultIcon {
    switch (inputType) {
      case InputType.time:
        return Icons.access_time_outlined;
      case InputType.both:
        return Icons.calendar_month_outlined;
      case InputType.date:
        return Icons.calendar_today_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: inputType,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(icon ?? _defaultIcon),
      ),
      validator: validator,
      initialValue: initialValue,
      firstDate: firstDate,
      lastDate: lastDate,
      valueTransformer: (value) => value?.toLocal(),
    );
  }
}
