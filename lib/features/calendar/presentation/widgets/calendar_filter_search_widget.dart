import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:intl/intl.dart';

class CalendarFilterSearchWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          // Header with toggle
          InkWell(
            onTap: onToggleVisibility,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: context.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText(
                      'Search & Filter Reservations',
                      style: AppTextStyle.titleMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isFilterVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          // Filter content
          if (isFilterVisible) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search field
                    AppTextField(
                      name: 'search',
                      label:
                          'Search by customer name, phone, or reservation number',
                      placeHolder: 'Enter search term...',
                      prefixIcon: const Icon(Icons.search),
                      validator: FormBuilderValidators.compose([]),
                    ),
                    const SizedBox(height: 16),

                    // Row for dropdowns and date range
                    Row(
                      children: [
                        // Status dropdown
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'status',
                            label: 'Status',
                            hintText: 'All Status',
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
                            initialValue: 'all',
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Menu dropdown - placeholder for now
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'menu',
                            label: 'Menu',
                            hintText: 'All Menus',
                            items: [
                              AppDropdownItem(value: 'all', label: 'All Menus'),
                              // TODO: Add actual menu items from provider
                            ],
                            initialValue: 'all',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Date range
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
                            validator: (val) {
                              final startDate = formKey
                                  .currentState
                                  ?.fields['start_date']
                                  ?.value;
                              if (val != null &&
                                  startDate != null &&
                                  val.isBefore(startDate)) {
                                return 'End date must be after start date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Apply Filters',
                            color: AppButtonColor.primary,
                            leadingIcon: const Icon(Icons.search, size: 18),
                            onPressed: onFilter,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: 'Reset',
                            color: AppButtonColor.secondary,
                            leadingIcon: const Icon(Icons.refresh, size: 18),
                            onPressed: onReset,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
