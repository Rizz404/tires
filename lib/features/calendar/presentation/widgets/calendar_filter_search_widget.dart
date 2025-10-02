import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:intl/intl.dart';

class CalendarFilterSearchWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const CalendarFilterSearchWidget({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  State<CalendarFilterSearchWidget> createState() =>
      _CalendarFilterSearchWidgetState();
}

class _CalendarFilterSearchWidgetState
    extends State<CalendarFilterSearchWidget> {
  @override
  void dispose() {
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
                Expanded(
                  child: AppText(
                    'Search & Filter Reservations',
                    style: AppTextStyle.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: widget.onToggleVisibility,
                  icon: Icon(
                    widget.isFilterVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  label: AppText(
                    widget.isFilterVisible ? 'Hide Filters' : 'Show Filters',
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    AppSearchField(
                      name: 'search',
                      hintText: 'Enter search term...',
                      label:
                          'Search by customer name, phone, or reservation number',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'status',
                            initialValue: 'all',
                            label: 'Status',
                            items: [
                              AppDropdownItem(
                                value: 'all',
                                label: 'All Status',
                              ),
                              AppDropdownItem(
                                value: 'pending',
                                label: 'Pending',
                              ),
                              AppDropdownItem(
                                value: 'confirmed',
                                label: 'Confirmed',
                              ),
                              AppDropdownItem(
                                value: 'completed',
                                label: 'Completed',
                              ),
                              AppDropdownItem(
                                value: 'cancelled',
                                label: 'Cancelled',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'menu',
                            initialValue: 'all',
                            label: 'Menu',
                            items: [
                              AppDropdownItem(value: 'all', label: 'All Menus'),
                              // TODO: Add actual menu items from provider
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'start_date',
                            inputType: InputType.date,
                            format: DateFormat('MMM dd, yyyy'),
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              hintText: 'Select start date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'end_date',
                            inputType: InputType.date,
                            format: DateFormat('MMM dd, yyyy'),
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              hintText: 'Select end date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          text: 'Reset',
                          onPressed: widget.onReset,
                          variant: AppButtonVariant.text,
                          isFullWidth: false,
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          text: 'Apply Filters',
                          onPressed: widget.onFilter,
                          variant: AppButtonVariant.filled,
                          isFullWidth: false,
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
