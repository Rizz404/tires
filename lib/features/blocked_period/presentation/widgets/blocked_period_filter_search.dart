import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
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
      AppDropdownItem<int>(
        value: 0,
        label: context.l10n.adminListBlockedPeriodScreenFiltersMenuAll,
      ),
      ...menus.map(
        (menu) => AppDropdownItem<int>(value: menu.id, label: menu.name),
      ),
    ];

    final statusItems = AppDropdownExtensions.createFilterItems(
      allLabel: context.l10n.adminListBlockedPeriodScreenFiltersStatusAll,
      filterValues: ['active', 'upcoming', 'expired'],
      filterLabels: [
        context.l10n.adminListBlockedPeriodScreenFiltersStatusActive,
        context.l10n.adminListBlockedPeriodScreenFiltersStatusUpcoming,
        context.l10n.adminListBlockedPeriodScreenFiltersStatusExpired,
      ],
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
                Expanded(
                  child: AppText(
                    context.l10n.adminListBlockedPeriodScreenFiltersTitle,
                    style: AppTextStyle.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onToggleVisibility,
                  icon: Icon(
                    isFilterVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  label: AppText(
                    isFilterVisible
                        ? context.l10n.adminListBlockedPeriodScreenFiltersHide
                        : context.l10n.adminListBlockedPeriodScreenFiltersShow,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                            label: context
                                .l10n
                                .adminListBlockedPeriodScreenFiltersMenuLabel,
                            initialValue: 0,
                            items: menuItems,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'status',
                            label: context
                                .l10n
                                .adminListBlockedPeriodScreenFiltersStatusLabel,
                            initialValue: 'all',
                            items: statusItems,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDateTimePicker(
                            name: 'start_date',
                            label: context
                                .l10n
                                .adminListBlockedPeriodScreenFiltersStartDateLabel,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AppDateTimePicker(
                            name: 'end_date',
                            label: context
                                .l10n
                                .adminListBlockedPeriodScreenFiltersEndDateLabel,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AppCheckbox(
                      name: 'all_menus',
                      title: AppText(
                        context
                            .l10n
                            .adminListBlockedPeriodScreenFiltersAllMenusLabel,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppSearchField(
                      name: 'search',
                      label: context
                          .l10n
                          .adminListBlockedPeriodScreenFiltersSearchLabel,
                      hintText: context
                          .l10n
                          .adminListBlockedPeriodScreenFiltersSearchPlaceholder,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          onPressed: onReset,
                          text: context
                              .l10n
                              .adminListBlockedPeriodScreenFiltersResetButton,
                          color: AppButtonColor.neutral,
                          isFullWidth: false,
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          onPressed: onFilter,
                          text: context
                              .l10n
                              .adminListBlockedPeriodScreenFiltersFilterButton,
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
