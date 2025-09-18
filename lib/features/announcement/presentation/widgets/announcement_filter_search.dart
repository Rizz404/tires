import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
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
  Timer? _debounceTimer;

  void _onSearchChanged(String? value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onFilter();
    });
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
                  context.l10n.adminListAnnouncementScreenFiltersTitle,
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
                        ? context.l10n.adminListAnnouncementScreenJsHideFilters
                        : context.l10n.adminListAnnouncementScreenJsShowFilters,
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
                          child: FormBuilderDropdown<String>(
                            name: 'status',
                            initialValue: 'all',
                            onChanged: (value) => widget.onFilter(),
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListAnnouncementScreenFiltersStatusLabel,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'all',
                                child: Text(
                                  context
                                      .l10n
                                      .adminListAnnouncementScreenFiltersAllStatuses,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'active',
                                child: Text(
                                  context
                                      .l10n
                                      .adminUpsertAnnouncementScreenStatusActive,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'inactive',
                                child: Text(
                                  context
                                      .l10n
                                      .adminUpsertAnnouncementScreenStatusInactive,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'published_at',
                            inputType: InputType.date,
                            onChanged: (value) => widget.onFilter(),
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListAnnouncementScreenFiltersStartDateLabel,
                            ),
                            format: DateFormat('dd/MM/yyyy'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'search',
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        labelText: context
                            .l10n
                            .adminListAnnouncementScreenFiltersSearchLabel,
                        hintText: context
                            .l10n
                            .adminListAnnouncementScreenFiltersSearchPlaceholder,
                        prefixIcon: const Icon(Icons.search),
                      ),
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
                                .adminListAnnouncementScreenFiltersResetButton,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: widget.onFilter,
                          child: Text(
                            context
                                .l10n
                                .adminListAnnouncementScreenFiltersFilterButton,
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
