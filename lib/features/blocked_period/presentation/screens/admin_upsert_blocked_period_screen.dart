import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';

import 'package:tires/features/blocked_period/domain/repositories/blocked_period_repository.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_mutation_state.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_providers.dart';
import 'package:tires/features/blocked_period/presentation/validations/blocked_period_validators.dart';
import 'package:tires/features/menu/presentation/providers/admin_menus_state.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/features/blocked_period/presentation/widgets/blocked_period_calendar.dart';

import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

enum DurationPreset { fullDay, twoDays, fullWeek, custom }

@RoutePage()
class AdminUpsertBlockedPeriodScreen extends ConsumerStatefulWidget {
  final BlockedPeriod? blockedPeriod;

  const AdminUpsertBlockedPeriodScreen({super.key, this.blockedPeriod});

  @override
  ConsumerState<AdminUpsertBlockedPeriodScreen> createState() =>
      _AdminUpsertBlockedPeriodScreenState();
}

class _AdminUpsertBlockedPeriodScreenState
    extends ConsumerState<AdminUpsertBlockedPeriodScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  DurationPreset _durationPreset = DurationPreset.fullDay;
  bool _isSubmitting = false;

  bool get _isEditMode => widget.blockedPeriod != null;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(adminMenuGetNotifierProvider.notifier)
          .getInitialAdminMenus(paginate: false);

      if (_isEditMode) {
        _populateForm();
      }
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.fields.forEach((key, field) {
      field.dispose();
    });
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    _formKey.currentState?.patchValue({'start_date': date});
  }

  void _onTimeRangeSelected(DateTime start, DateTime end) {
    _formKey.currentState?.patchValue({'start_time': start, 'end_time': end});
  }

  void _populateForm() {
    final blockedPeriod = widget.blockedPeriod;
    if (blockedPeriod != null) {
      _formKey.currentState?.patchValue({
        'reason_en':
            blockedPeriod.translations?.en.reason ?? blockedPeriod.reason,
        'reason_ja': blockedPeriod.translations?.ja.reason,
        'block_all_menus': blockedPeriod.allMenuForBlockedPeriods,
        'menu_id': blockedPeriod.menuId,
        'start_date': blockedPeriod.startDatetime,
        'end_date': blockedPeriod.endDatetime,
        'start_time': blockedPeriod.startDatetime,
        'end_time': blockedPeriod.endDatetime,
      });

      // Determine duration preset
      final duration = blockedPeriod.endDatetime.difference(
        blockedPeriod.startDatetime,
      );
      if (duration.inDays == 1) {
        _durationPreset = DurationPreset.fullDay;
      } else if (duration.inDays == 2) {
        _durationPreset = DurationPreset.twoDays;
      } else if (duration.inDays == 7) {
        _durationPreset = DurationPreset.fullWeek;
      } else {
        _durationPreset = DurationPreset.custom;
      }

      setState(() {});
    }
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final notifier = ref.read(blockedPeriodMutationNotifierProvider.notifier);

      final reasonEn = values['reason_en'] as String;
      final allMenus = values['block_all_menus'] as bool;
      final menuId = allMenus ? null : values['menu_id'] as int?;

      DateTime startDateTime;
      DateTime endDateTime;

      if (_durationPreset != DurationPreset.custom) {
        final startDate = values['start_date'] as DateTime;

        switch (_durationPreset) {
          case DurationPreset.fullDay:
            startDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              0,
              0,
            );
            endDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              23,
              59,
            );
            break;
          case DurationPreset.twoDays:
            startDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              0,
              0,
            );
            endDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day + 1,
              23,
              59,
            );
            break;
          case DurationPreset.fullWeek:
            startDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day,
              0,
              0,
            );
            endDateTime = DateTime(
              startDate.year,
              startDate.month,
              startDate.day + 6,
              23,
              59,
            );
            break;
          case DurationPreset.custom:
            // This case won't be reached, but included for completeness
            startDateTime = DateTime.now();
            endDateTime = DateTime.now();
            break;
        }
      } else {
        final startDate = values['start_date'] as DateTime;
        final endDate = values['end_date'] ?? startDate;
        final startTime = values['start_time'] as DateTime;
        final endTime = values['end_time'] as DateTime;

        startDateTime = DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
          startTime.hour,
          startTime.minute,
        );

        endDateTime = DateTime(
          (endDate as DateTime).year,
          endDate.month,
          endDate.day,
          endTime.hour,
          endTime.minute,
        );
      }

      // Validate date range
      final rangeError = BlockedPeriodValidators.validateDateTimeRange(
        startDate: startDateTime,
        endDate: endDateTime,
        startTime: startDateTime,
        endTime: endDateTime,
      );

      if (rangeError != null) {
        setState(() {
          _isSubmitting = false;
        });
        AppToast.showError(context, message: rangeError);
        return;
      }

      if (_isEditMode) {
        notifier.updateBlockedPeriod(
          UpdateBlockedPeriodParams(
            id: widget.blockedPeriod!.id,
            menuId: menuId,
            startDatetime: startDateTime,
            endDatetime: endDateTime,
            reason: reasonEn,
            allMenus: allMenus,
          ),
        );
      } else {
        notifier.createBlockedPeriod(
          CreateBlockedPeriodParams(
            menuId: menuId,
            startDatetime: startDateTime,
            endDatetime: endDateTime,
            reason: reasonEn,
            allMenus: allMenus,
          ),
        );
      }
    } else {
      setState(() {
        _isSubmitting = false;
      });
      AppToast.showError(
        context,
        message: 'Please correct the errors in the form.',
      );
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              context.theme.dialogTheme.backgroundColor ??
              context.theme.colorScheme.surface,
          title: AppText(
            context.l10n.adminListBlockedPeriodScreenConfirmationDeleteTitle,
          ),
          content: AppText(
            context.l10n.adminListBlockedPeriodScreenConfirmationDeleteMessage,
          ),
          actions: [
            AppButton(
              text: context
                  .l10n
                  .adminListBlockedPeriodScreenDetailDeleteModalCancelButton,
              onPressed: () => Navigator.of(context).pop(),
              variant: AppButtonVariant.outlined,
              color: AppButtonColor.neutral,
              isFullWidth: false,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: context
                  .l10n
                  .adminListBlockedPeriodScreenDetailDeleteModalConfirmButton,
              onPressed: () {
                Navigator.of(context).pop();
                final notifier = ref.read(
                  blockedPeriodMutationNotifierProvider.notifier,
                );
                notifier.deleteBlockedPeriod(
                  DeleteBlockedPeriodParams(id: widget.blockedPeriod!.id),
                );
              },
              variant: AppButtonVariant.filled,
              color: AppButtonColor.error,
              isFullWidth: false,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    ref.listen(blockedPeriodMutationNotifierProvider, (previous, next) {
      if (next.status != BlockedPeriodMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == BlockedPeriodMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message: _isEditMode
              ? l10n.blockedPeriodNotificationUpdateSuccess
              : l10n.blockedPeriodNotificationCreateSuccess,
        );
        context.router.pop();
      } else if (next.status == BlockedPeriodMutationStatus.error &&
          next.errorMessage != null) {
        AppToast.showError(context, message: next.errorMessage!);
      }
    });

    final mutationState = ref.watch(blockedPeriodMutationNotifierProvider);
    final isLoading =
        mutationState.status == BlockedPeriodMutationStatus.loading;

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ScreenWrapper(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(l10n),
                const SizedBox(height: 24),
                _buildForm(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          _isEditMode
              ? l10n.adminUpsertBlockedPeriodScreenEditPageTitle
              : l10n.adminUpsertBlockedPeriodScreenCreateTitle,
          style: AppTextStyle.headlineSmall,
        ),
        const SizedBox(height: 4),
        AppText(
          _isEditMode
              ? l10n.adminUpsertBlockedPeriodScreenEditPageDescription
              : l10n.adminUpsertBlockedPeriodScreenCreateDescription,
          style: AppTextStyle.bodyMedium,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          softWrap: true,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildForm(L10n l10n) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Todo: Overflowed error, fix nanti
          // BlockedPeriodCalendar(
          //   initialDate: widget.blockedPeriod?.startDatetime ?? DateTime.now(),
          //   onDateSelected: _onDateSelected,
          //   onTimeRangeSelected: _onTimeRangeSelected,
          // ),
          // const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTargetMenuSection(l10n),
                  const SizedBox(height: 24),
                  _buildReasonSection(l10n),
                  const SizedBox(height: 24),
                  _buildDurationSection(l10n),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildActionButtons(l10n),
        ],
      ),
    );
  }

  Widget _buildTargetMenuSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertBlockedPeriodScreenTargetMenuTitle,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 8),
        AppText(
          l10n.adminUpsertBlockedPeriodScreenTargetMenuDescription,
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        FormBuilderCheckbox(
          name: 'block_all_menus',
          title: AppText(
            l10n.adminUpsertBlockedPeriodScreenCreateFormAllMenusLabel,
          ),
          initialValue: false,
          onChanged: (value) {
            setState(() {}); // Rebuild to show/hide menu dropdown
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 16),
        if (!(_formKey.currentState?.fields['block_all_menus']?.value ?? false))
          Builder(
            builder: (context) {
              final menusState = ref.watch(adminMenuGetNotifierProvider);

              if (menusState.status == AdminMenusStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (menusState.status == AdminMenusStatus.error) {
                return AppText(
                  'Error loading menus: ${menusState.errorMessage ?? 'Unknown error'}',
                );
              }

              return FormBuilderDropdown<int>(
                name: 'menu_id',
                decoration: InputDecoration(
                  labelText: l10n
                      .adminUpsertBlockedPeriodScreenCreateFormSelectMenuLabel,
                  hintText: l10n
                      .adminUpsertBlockedPeriodScreenCreateFormSelectMenuPlaceholder,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  final blockAllMenus =
                      _formKey.currentState?.fields['block_all_menus']?.value ??
                      false;
                  if (!blockAllMenus && value == null) {
                    return 'Please select a menu or choose to block all menus';
                  }
                  return null;
                },
                items: menusState.menus
                    .map(
                      (menu) => DropdownMenuItem(
                        value: menu.id,
                        child: AppText(menu.name),
                      ),
                    )
                    .toList(),
              );
            },
          ),
      ],
    );
  }

  Widget _buildReasonSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertBlockedPeriodScreenReasonTitle,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'reason_en',
          label: l10n.adminUpsertBlockedPeriodScreenReasonEnLabel,
          placeHolder: l10n.adminUpsertBlockedPeriodScreenReasonEnPlaceholder,
          validator: BlockedPeriodValidators.reasonEn(context),
          type: AppTextFieldType.multiline,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'reason_ja',
          label: l10n.adminUpsertBlockedPeriodScreenReasonJaLabel,
          placeHolder: l10n.adminUpsertBlockedPeriodScreenReasonJaPlaceholder,
          validator: BlockedPeriodValidators.reasonJa(context),
          type: AppTextFieldType.multiline,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDurationSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertBlockedPeriodScreenDurationTitle,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildDurationPreset(l10n),
        const SizedBox(height: 16),
        _buildDateTimeFields(l10n),
      ],
    );
  }

  Widget _buildDurationPreset(L10n l10n) {
    return FormBuilderRadioGroup<DurationPreset>(
      name: 'duration_preset',
      decoration: InputDecoration(
        labelText: l10n.adminUpsertBlockedPeriodScreenDurationPresetLabel,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
        ),
      ),
      initialValue: _durationPreset,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _durationPreset = value;
          });
          // TODO: Update date/time fields based on preset
        }
      },
      options: [
        FormBuilderFieldOption(
          value: DurationPreset.fullDay,
          child: AppText(
            l10n.adminUpsertBlockedPeriodScreenDurationPresetsFullDay,
          ),
        ),
        FormBuilderFieldOption(
          value: DurationPreset.twoDays,
          child: AppText(
            l10n.adminUpsertBlockedPeriodScreenDurationPresetsFull2Days,
          ),
        ),
        FormBuilderFieldOption(
          value: DurationPreset.fullWeek,
          child: AppText(
            l10n.adminUpsertBlockedPeriodScreenDurationPresetsFullWeek,
          ),
        ),
        FormBuilderFieldOption(
          value: DurationPreset.custom,
          child: AppText(
            l10n.adminUpsertBlockedPeriodScreenDurationPresetsCustom,
          ),
        ),
      ],
      separator: const SizedBox(height: 8),
      orientation: OptionsOrientation.vertical,
    );
  }

  Widget _buildDateTimeFields(L10n l10n) {
    final isCustom = _durationPreset == DurationPreset.custom;
    return Column(
      children: [
        FormBuilderDateTimePicker(
          name: 'start_date',
          decoration: InputDecoration(
            labelText:
                l10n.adminUpsertBlockedPeriodScreenCreateFormStartDateLabel,
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            border: const OutlineInputBorder(),
          ),
          initialValue: widget.blockedPeriod?.startDatetime ?? DateTime.now(),
          inputType: InputType.date,
          format: DateFormat('yyyy/MM/dd'),
          validator: BlockedPeriodValidators.startDate(context),
          onChanged: (val) {
            // This is to make sure the calendar view is updated when the date is changed manually
            if (val != null) {
              setState(() {});
            }
          },
        ),
        if (isCustom) ...[
          const SizedBox(height: 16),
          FormBuilderDateTimePicker(
            name: 'end_date',
            decoration: InputDecoration(
              labelText:
                  l10n.adminUpsertBlockedPeriodScreenCreateFormEndDateLabel,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
              border: const OutlineInputBorder(),
            ),
            inputType: InputType.date,
            format: DateFormat('yyyy/MM/dd'),
            validator: BlockedPeriodValidators.endDate(context),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FormBuilderDateTimePicker(
                name: 'start_time',
                decoration: InputDecoration(
                  labelText: l10n
                      .adminUpsertBlockedPeriodScreenCreateFormStartTimeLabel,
                  suffixIcon: const Icon(Icons.access_time_outlined),
                  border: const OutlineInputBorder(),
                ),
                initialValue:
                    widget.blockedPeriod?.startDatetime ??
                    DateTime(0, 1, 1, 0, 0),
                inputType: InputType.time,
                format: DateFormat('HH:mm'),
                enabled: isCustom,
                validator: isCustom
                    ? BlockedPeriodValidators.startTime(context)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FormBuilderDateTimePicker(
                name: 'end_time',
                decoration: InputDecoration(
                  labelText:
                      l10n.adminUpsertBlockedPeriodScreenCreateFormEndTimeLabel,
                  suffixIcon: const Icon(Icons.access_time_outlined),
                  border: const OutlineInputBorder(),
                ),
                initialValue:
                    widget.blockedPeriod?.endDatetime ??
                    DateTime(0, 1, 1, 23, 59),
                inputType: InputType.time,
                format: DateFormat('HH:mm'),
                enabled: isCustom,
                validator: isCustom
                    ? BlockedPeriodValidators.endTime(context)
                    : null,
              ),
            ),
          ],
        ),
        if (!isCustom) ...[
          const SizedBox(height: 8),
          AppText(
            _getDurationPresetDescription(),
            style: AppTextStyle.bodySmall,
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ],
      ],
    );
  }

  String _getDurationPresetDescription() {
    switch (_durationPreset) {
      case DurationPreset.fullDay:
        return 'Full day from 00:00 to 23:59';
      case DurationPreset.twoDays:
        return 'Two consecutive days from 00:00 to 23:59';
      case DurationPreset.fullWeek:
        return 'Full week (7 days) from 00:00 to 23:59';
      case DurationPreset.custom:
        return 'Custom duration with specific dates and times';
    }
  }

  Widget _buildActionButtons(L10n l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_isEditMode)
          AppButton(
            text: l10n.adminListBlockedPeriodScreenDetailActionsDelete,
            onPressed: _showDeleteConfirmationDialog,
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.error,
            isFullWidth: false,
          )
        else
          AppButton(
            text: l10n.adminUpsertBlockedPeriodScreenBackToListButton,
            onPressed: () => context.router.pop(),
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.neutral,
            isFullWidth: false,
          ),
        const SizedBox(width: 16),
        AppButton(
          text: _isEditMode
              ? l10n.adminUpsertBlockedPeriodScreenEditButtonSaveText
              : l10n.adminUpsertBlockedPeriodScreenCreateSaveButton,
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
