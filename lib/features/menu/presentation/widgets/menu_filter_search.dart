import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuFilterSearch extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const MenuFilterSearch({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  'Filters & Search',
                  style: AppTextStyle.titleLarge,
                ),
                TextButton.icon(
                  onPressed: onToggleVisibility,
                  icon: Icon(
                    isFilterVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  label: AppText(
                    isFilterVisible ? 'Hide Filters' : 'Show Filters',
                  ),
                ),
              ],
            ),
            if (isFilterVisible) ...[
              const SizedBox(height: 16),
              FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    FormBuilderDropdown<String>(
                      name: 'status',
                      initialValue: 'all',
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('All Statuses'),
                        ),
                        DropdownMenuItem(
                          value: 'active',
                          child: Text('Active'),
                        ),
                        DropdownMenuItem(
                          value: 'inactive',
                          child: Text('Inactive'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'min_price',
                            decoration: const InputDecoration(
                              labelText: 'Min Price Range',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'max_price',
                            decoration: const InputDecoration(
                              labelText: 'Max Price Range',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'search',
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Search menu name or description...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onReset,
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: onFilter,
                          child: const Text('Filter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
