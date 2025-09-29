import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';

import 'package:tires/features/reservation/domain/usecases/update_reservation_usecase.dart';

import 'package:tires/features/reservation/presentation/providers/reservation_mutation_state.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_dropdown.dart';
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AdminUpsertReservationScreen extends ConsumerStatefulWidget {
  final Reservation? reservation;

  const AdminUpsertReservationScreen({super.key, this.reservation});

  @override
  ConsumerState<AdminUpsertReservationScreen> createState() =>
      _AdminUpsertReservationScreenState();
}

class _AdminUpsertReservationScreenState
    extends ConsumerState<AdminUpsertReservationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;
  List<Menu> _availableMenus = [];

  bool get _isEditMode => widget.reservation != null;

  String? _getInitialMenuValue() {
    if (!_isEditMode || widget.reservation == null || _availableMenus.isEmpty) {
      return null;
    }

    final reservationMenuId = widget.reservation!.menu.id.toString();
    final menuExists = _availableMenus.any(
      (menu) => menu.id.toString() == reservationMenuId,
    );

    return menuExists ? reservationMenuId : null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMenus();
    });
  }

  Future<void> _loadMenus() async {
    // Load available menus from provider
    await ref
        .read(adminMenuGetNotifierProvider.notifier)
        .getInitialAdminMenus();
    final menuState = ref.read(adminMenuGetNotifierProvider);
    if (menuState.menus.isNotEmpty) {
      setState(() {
        _availableMenus = menuState.menus;
      });
      // Populate form after menus are loaded and UI is rebuilt
      if (_isEditMode) {
        _populateForm();
      }
    }
  }

  void _populateForm() {
    final reservation = widget.reservation;
    if (reservation != null && _formKey.currentState != null) {
      // Use Future.delayed to ensure form is fully built before patching values
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _formKey.currentState?.patchValue({
          'menu_id': reservation.menu.id.toString(),
          'reservation_datetime': DateFormat(
            'yyyy-MM-dd HH:mm',
          ).format(reservation.reservationDatetime),
          'number_of_people': reservation.numberOfPeople.toString(),
          'amount': reservation.amount.raw.toString(),
          'status': reservation.status.value.name,
          'notes': reservation.notes ?? '',
        });
      });
    }
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting) return;

    setState(() {
      _validationErrors = null;
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final notifier = ref.read(reservationMutationNotifierProvider.notifier);

      final menuId = int.parse(values['menu_id'] as String);
      final reservationDatetime = DateFormat(
        'yyyy-MM-dd HH:mm',
      ).parse(values['reservation_datetime'] as String);
      final numberOfPeople = int.parse(values['number_of_people'] as String);
      final amount = int.parse(values['amount'] as String);
      final notes = values['notes'] as String?;

      if (_isEditMode) {
        final statusString = values['status'] as String;
        final status = ReservationStatusValue.values.firstWhere(
          (s) => s.name == statusString,
        );

        notifier.updateReservation(
          UpdateReservationParams(
            id: widget.reservation!.id,
            menuId: menuId,
            reservationDatetime: reservationDatetime,
            numberOfPeople: numberOfPeople,
            amount: amount,
            status: status,
            notes: notes?.isNotEmpty == true ? notes : null,
          ),
        );
      } else {
        notifier.createReservation(
          menuId: menuId,
          reservationDatetime: reservationDatetime,
          numberOfPeople: numberOfPeople,
          amount: amount,
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
          title: const AppText('Delete Reservation'),
          content: const AppText(
            'Are you sure you want to delete this reservation? This action cannot be undone.',
          ),
          actions: [
            AppButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
              variant: AppButtonVariant.outlined,
              color: AppButtonColor.neutral,
              isFullWidth: false,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: 'Delete',
              onPressed: () {
                Navigator.of(context).pop();
                final notifier = ref.read(
                  reservationMutationNotifierProvider.notifier,
                );
                notifier.deleteReservation(id: widget.reservation!.id);
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

    ref.listen(reservationMutationNotifierProvider, (previous, next) {
      if (next.status != ReservationMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == ReservationMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message:
              next.successMessage ??
              (_isEditMode
                  ? 'Reservation updated successfully'
                  : 'Reservation created successfully'),
        );
        context.router.pop();
      } else if (next.status == ReservationMutationStatus.error &&
          next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          debugPrint(next.failure.toString());
          debugPrint(next.failure?.message);
          AppToast.showError(context, message: next.failure!.message);
        }
      }
    });

    final mutationState = ref.watch(reservationMutationNotifierProvider);
    final isLoading = mutationState.status == ReservationMutationStatus.loading;

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
          _isEditMode ? 'Edit Reservation' : 'Add Reservation',
          style: AppTextStyle.headlineSmall,
        ),
        const SizedBox(height: 4),
        AppText(
          _isEditMode
              ? 'Update reservation details'
              : 'Create a new reservation',
          style: AppTextStyle.bodyMedium,
          softWrap: true,
        ),
      ],
    );
  }

  Widget _buildForm(L10n l10n) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_validationErrors != null)
            ErrorSummaryBox(errors: _validationErrors!),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomerInfo(l10n),
                  const SizedBox(height: 24),
                  _buildReservationDetails(l10n),
                  const SizedBox(height: 24),
                  _buildCustomerSettings(l10n),
                  if (_isEditMode) ...[
                    const SizedBox(height: 24),
                    _buildStatusSettings(l10n),
                  ],
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

  Widget _buildCustomerInfo(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText('Customer Information', style: AppTextStyle.titleMedium),
        const SizedBox(height: 16),
        if (_isEditMode && widget.reservation?.customerInfo != null)
          // Show existing customer info for edit mode
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    AppText(
                      widget.reservation!.customerInfo.fullName,
                      style: AppTextStyle.bodyMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                if (widget.reservation!.customerInfo.email.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        widget.reservation!.customerInfo.email,
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
                  ),
                ],
                if (widget
                    .reservation!
                    .customerInfo
                    .phoneNumber
                    .isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        widget.reservation!.customerInfo.phoneNumber,
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
                  ),
                ],
                if (widget
                    .reservation!
                    .customerInfo
                    .fullNameKana
                    .isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.translate,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        widget.reservation!.customerInfo.fullNameKana,
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.reservation!.customerInfo.isGuest
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText(
                    widget.reservation!.customerInfo.isGuest
                        ? 'Guest'
                        : 'Member',
                    style: AppTextStyle.labelSmall,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        else
          // Show placeholder for create mode
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person_add,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 8),
                AppText(
                  'New Reservation',
                  style: AppTextStyle.bodyMedium,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                AppText(
                  'Customer information will be collected during reservation process',
                  style: AppTextStyle.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildReservationDetails(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText('Reservation Details', style: AppTextStyle.titleMedium),
        const SizedBox(height: 16),
        // Menu Selection
        AppDropdown<String>(
          name: 'menu_id',
          label: 'Menu',
          hintText: 'Select a menu',
          initialValue: _getInitialMenuValue(),
          items: _availableMenus
              .map(
                (menu) => AppDropdownItem<String>(
                  value: menu.id.toString(),
                  label: menu.name,
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a menu';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // Reservation Date & Time
        AppTextField(
          name: 'reservation_datetime',
          label: 'Reservation Date & Time',
          placeHolder: 'YYYY-MM-DD HH:MM',
          type: AppTextFieldType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter reservation date and time';
            }
            try {
              DateFormat('yyyy-MM-dd HH:mm').parse(value);
            } catch (e) {
              return 'Please enter valid date format (YYYY-MM-DD HH:MM)';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                name: 'number_of_people',
                label: 'Number of People',
                placeHolder: '1',
                type: AppTextFieldType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of people';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number < 1) {
                    return 'Please enter a valid number (minimum 1)';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                name: 'amount',
                label: 'Amount',
                placeHolder: '0',
                type: AppTextFieldType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  final amount = int.tryParse(value);
                  if (amount == null || amount < 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Additional Information',
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'notes',
          label: 'Notes',
          placeHolder: 'Additional notes...',
          type: AppTextFieldType.multiline,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildStatusSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText('Status Settings', style: AppTextStyle.titleMedium),
        const SizedBox(height: 16),
        AppRadioGroup<String>(
          name: 'status',
          label: 'Reservation Status',
          options: [
            FormBuilderFieldOption(
              value: ReservationStatusValue.pending.name,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('Pending', style: AppTextStyle.bodyMedium),
                  Text(
                    'Reservation is awaiting confirmation',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            FormBuilderFieldOption(
              value: ReservationStatusValue.confirmed.name,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('Confirmed', style: AppTextStyle.bodyMedium),
                  Text(
                    'Reservation has been confirmed',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            FormBuilderFieldOption(
              value: ReservationStatusValue.completed.name,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('Completed', style: AppTextStyle.bodyMedium),
                  Text(
                    'Service has been completed',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            FormBuilderFieldOption(
              value: ReservationStatusValue.cancelled.name,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('Cancelled', style: AppTextStyle.bodyMedium),
                  Text(
                    'Reservation has been cancelled',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(L10n l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_isEditMode)
          AppButton(
            text: 'Delete',
            onPressed: _showDeleteConfirmationDialog,
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.error,
            isFullWidth: false,
          )
        else
          AppButton(
            text: 'Cancel',
            onPressed: () => context.router.pop(),
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.neutral,
            isFullWidth: false,
          ),
        const SizedBox(width: 16),
        AppButton(
          text: _isEditMode ? 'Update Reservation' : 'Save Reservation',
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
