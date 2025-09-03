import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AppDropdownItem<T> {
  final T value;
  final String label;
  final Widget? icon;

  const AppDropdownItem({required this.value, required this.label, this.icon});
}

class AppDropdown<T> extends StatelessWidget {
  final String name;
  final T? initialValue;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? label;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Widget? prefixIcon;
  final bool isExpanded;
  final double? width;
  final String? Function(T?)? validator;

  const AppDropdown({
    super.key,
    required this.name,
    this.initialValue,
    required this.items,
    this.onChanged,
    this.hintText,
    this.label,
    this.enabled = true,
    this.contentPadding,
    this.fillColor,
    this.prefixIcon,
    this.isExpanded = true,
    this.width,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget dropdown = FormBuilderDropdown<T>(
      name: name,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.icon != null) ...[item.icon!, const SizedBox(width: 8)],
              Flexible(
                child: AppText(
                  item.label,
                  style: AppTextStyle.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      isExpanded: isExpanded,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText ?? 'Select option',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor:
            fillColor ?? theme.colorScheme.surface.withValues(alpha: 0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      dropdownColor: theme.colorScheme.surface,
      iconEnabledColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      iconDisabledColor: theme.colorScheme.onSurface.withValues(alpha: 0.3),
    );

    if (width != null) {
      dropdown = SizedBox(width: width, child: dropdown);
    }

    return dropdown;
  }
}

// Extension to create common dropdown items
extension AppDropdownExtensions on AppDropdown {
  static List<AppDropdownItem<String>> createFilterItems({
    required String allLabel,
    required List<String> filterValues,
    required List<String> filterLabels,
    List<IconData>? filterIcons,
  }) {
    final items = <AppDropdownItem<String>>[
      AppDropdownItem(
        value: 'all',
        label: allLabel,
        icon: const Icon(Icons.list_alt, size: 18),
      ),
    ];

    for (int i = 0; i < filterValues.length; i++) {
      items.add(
        AppDropdownItem(
          value: filterValues[i],
          label: filterLabels[i],
          icon: filterIcons != null && i < filterIcons.length
              ? Icon(filterIcons[i], size: 18)
              : null,
        ),
      );
    }

    return items;
  }
}
