import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class ContactFilterSearch extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isFilterVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onFilter;
  final VoidCallback onReset;

  const ContactFilterSearch({
    super.key,
    required this.formKey,
    required this.isFilterVisible,
    required this.onToggleVisibility,
    required this.onFilter,
    required this.onReset,
  });

  @override
  State<ContactFilterSearch> createState() => _ContactFilterSearchState();
}

class _ContactFilterSearchState extends State<ContactFilterSearch> {
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
                Expanded(
                  child: AppText(
                    context.l10n.adminListContactScreenFilterTitle,
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
                        ? context.l10n.adminListContactScreenFilterHideButton
                        : context.l10n.adminListContactScreenFilterShowButton,
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
                          child: FormBuilderDropdown<String>(
                            name: 'status',
                            initialValue: 'all',
                            onChanged: (value) => widget.onFilter(),
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListContactScreenFilterStatusLabel,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'all',
                                child: Text(
                                  context
                                      .l10n
                                      .adminListContactScreenFilterStatusAll,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'pending',
                                child: Text(
                                  context
                                      .l10n
                                      .adminUpsertContactScreenStatusPending,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'replied',
                                child: Text(
                                  context
                                      .l10n
                                      .adminUpsertContactScreenStatusReplied,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'start_date',
                            inputType: InputType.date,
                            onChanged: (value) => widget.onFilter(),
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListContactScreenFilterStartDateLabel,
                            ),
                            format: DateFormat('dd/MM/yyyy'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            name: 'end_date',
                            inputType: InputType.date,
                            onChanged: (value) => widget.onFilter(),
                            decoration: InputDecoration(
                              labelText: context
                                  .l10n
                                  .adminListContactScreenFilterEndDateLabel,
                            ),
                            format: DateFormat('dd/MM/yyyy'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'search',
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        labelText: context
                            .l10n
                            .adminListContactScreenFilterSearchLabel,
                        hintText: context
                            .l10n
                            .adminListContactScreenFilterSearchPlaceholder,
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
                                .adminListContactScreenFilterResetButton,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: widget.onFilter,
                          child: Text(
                            context
                                .l10n
                                .adminListContactScreenFilterFilterButton,
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
