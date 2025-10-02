import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_search_field.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class MenuFilterSearch extends StatefulWidget {
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
  State<MenuFilterSearch> createState() => _MenuFilterSearchState();
}

class _MenuFilterSearchState extends State<MenuFilterSearch> {
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
                    context.l10n.adminListMenuScreenFiltersSearch,
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
                        ? context.l10n.adminListMenuScreenHideFilters
                        : context.l10n.adminListMenuScreenShowFilters,
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
                    AppDropdown<String>(
                      name: 'status',
                      initialValue: 'all',
                      label: context.l10n.adminListMenuScreenStatus,
                      items: [
                        AppDropdownItem(
                          value: 'all',
                          label: context.l10n.adminListMenuScreenAllStatuses,
                        ),
                        AppDropdownItem(
                          value: 'active',
                          label: context.l10n.adminListMenuScreenActive,
                        ),
                        AppDropdownItem(
                          value: 'inactive',
                          label: context.l10n.adminListMenuScreenInactive,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'min_price',
                            decoration: InputDecoration(
                              labelText:
                                  context.l10n.adminListMenuScreenMinPriceRange,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'max_price',
                            decoration: InputDecoration(
                              labelText:
                                  context.l10n.adminListMenuScreenMaxPriceRange,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppSearchField(
                      name: 'search',
                      hintText:
                          context.l10n.adminListMenuScreenSearchPlaceholder,
                      label: context.l10n.adminListMenuScreenSearch,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          text: context.l10n.adminListMenuScreenReset,
                          onPressed: widget.onReset,
                          variant: AppButtonVariant.text,
                          isFullWidth: false,
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          text: context.l10n.adminListMenuScreenFilter,
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
