import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_date_time_picker.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class BlockedPeriodFilterSearch extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final List<Menu> menus;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const BlockedPeriodFilterSearch({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.menus,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      const AppDropdownItem<int>(value: 0, label: 'All Menus'),
      ...menus.map(
        (menu) => AppDropdownItem<int>(value: menu.id, label: menu.name),
      ),
    ];

    final statusItems = AppDropdownExtensions.createFilterItems(
      allLabel: 'All Statuses',
      filterValues: ['active', 'upcoming', 'expired'],
      filterLabels: ['Active', 'Upcoming', 'Expired'],
      filterIcons: [
        Icons.play_circle_fill_outlined,
        Icons.timelapse_outlined,
        Icons.history_outlined,
      ],
    );

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
                  'Filter & Search',
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDropdown<int>(
                            name: 'menu_id',
                            label: 'Menu',
                            initialValue: 0,
                            items: menuItems,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'status',
                            label: 'Status',
                            initialValue: 'all',
                            items: statusItems,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDateTimePicker(
                            name: 'start_date',
                            label: 'Start Date',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AppDateTimePicker(
                            name: 'end_date',
                            label: 'End Date',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const AppCheckbox(
                      name: 'all_menus',
                      title: AppText('Show periods blocking all menus only'),
                    ),
                    const SizedBox(height: 16),
                    const AppSearchField(
                      name: 'search',
                      label: 'Search by Reason',
                      hintText: 'Enter reason keyword...',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          onPressed: onReset,
                          text: 'Reset',
                          color: AppButtonColor.neutral,
                          isFullWidth: false,
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          onPressed: onFilter,
                          text: 'Filter',
                          color: AppButtonColor.primary,
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
