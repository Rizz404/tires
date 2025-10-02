import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class AnnouncementFilterSearch extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const AnnouncementFilterSearch({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  State<AnnouncementFilterSearch> createState() =>
      _AnnouncementFilterSearchState();
}

class _AnnouncementFilterSearchState extends State<AnnouncementFilterSearch> {
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
                    context.l10n.adminListAnnouncementScreenFiltersTitle,
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
                    widget.isFilterVisible
                        ? context.l10n.adminListAnnouncementScreenJsHideFilters
                        : context.l10n.adminListAnnouncementScreenJsShowFilters,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppDropdown<String>(
                            name: 'status',
                            initialValue: 'all',
                            label: context
                                .l10n
                                .adminListAnnouncementScreenFiltersStatusLabel,
                            items: [
                              AppDropdownItem(
                                value: 'all',
                                label: context
                                    .l10n
                                    .adminListAnnouncementScreenFiltersAllStatuses,
                              ),
                              AppDropdownItem(
                                value: 'active',
                                label: context
                                    .l10n
                                    .adminUpsertAnnouncementScreenStatusActive,
                              ),
                              AppDropdownItem(
                                value: 'inactive',
                                label: context
                                    .l10n
                                    .adminUpsertAnnouncementScreenStatusInactive,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'published_at',
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListAnnouncementScreenFiltersStartDateLabel,
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppSearchField(
                      name: 'search',
                      hintText: context
                          .l10n
                          .adminListAnnouncementScreenFiltersSearchPlaceholder,
                      label: context
                          .l10n
                          .adminListAnnouncementScreenFiltersSearchLabel,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          text: context
                              .l10n
                              .adminListAnnouncementScreenFiltersResetButton,
                          onPressed: widget.onReset,
                          variant: AppButtonVariant.text,
                          isFullWidth: false,
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          text: context
                              .l10n
                              .adminListAnnouncementScreenFiltersFilterButton,
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
