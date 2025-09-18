import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class CustomerFilterSearch extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const CustomerFilterSearch({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  State<CustomerFilterSearch> createState() => _CustomerFilterSearchState();
}

class _CustomerFilterSearchState extends State<CustomerFilterSearch> {
  Timer? _debounceTimer;

  void _onSearchChanged(String? value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onFilter();
    });
  }

  void _onFilterChanged() {
    widget.onFilter();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

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
                AppText(
                  context.l10n.adminListCustomerManagementFiltersTitle,
                  style: AppTextStyle.titleLarge,
                ),
                TextButton.icon(
                  onPressed: widget.onToggleVisibility,
                  icon: Icon(
                    widget.isFilterVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  label: AppText(
                    widget.isFilterVisible
                        ? context
                              .l10n
                              .adminListCustomerManagementFiltersHideFilters
                        : context
                              .l10n
                              .adminListCustomerManagementFiltersShowFilters,
                  ),
                ),
              ],
            ),
            if (widget.isFilterVisible) ...[
              const SizedBox(height: 16),
              FormBuilder(
                key: widget.formKey,
                child: Column(
                  children: [
                    FormBuilderDropdown<String>(
                      name: 'status',
                      initialValue: 'all',
                      decoration: InputDecoration(
                        labelText: context
                            .l10n
                            .adminListCustomerManagementFiltersTypeLabel,
                      ),
                      onChanged: (_) => _onFilterChanged(),
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersAllTypes,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'first_time',
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersFirstTime,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'repeat',
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersRepeat,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'dormant',
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersDormant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'search',
                      decoration: InputDecoration(
                        labelText: context
                            .l10n
                            .adminListCustomerManagementFiltersSearchLabel,
                        hintText: context
                            .l10n
                            .adminListCustomerManagementFiltersSearchPlaceholder,
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: _onSearchChanged,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: widget.onReset,
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersResetButton,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: widget.onFilter,
                          child: Text(
                            context
                                .l10n
                                .adminListCustomerManagementFiltersFilterButton,
                          ),
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
