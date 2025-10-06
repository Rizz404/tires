import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/presentation/providers/menu_providers.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/presentation/providers/users_providers.dart';
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
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_searchable_dropdown.dart';
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
  bool _isLoadingMenus = false;
  List<User> _availableUsers = [];
  bool _isLoadingUsers = false;
  bool _isDisposed = false;
  bool _hasPopulatedForm = false;

  bool get _isEditMode => widget.reservation != null;

  String? get _initialMenuValue {
    if (!_isEditMode || widget.reservation == null) {
      return null;
    }

    final reservationMenuId = widget.reservation!.menu.id.toString();

    debugPrint('DEBUG: _initialMenuValue called');
    debugPrint('DEBUG: reservationMenuId = $reservationMenuId');
    debugPrint('DEBUG: returning = $reservationMenuId');

    return reservationMenuId;
  }

  String? get _initialUserValue {
    if (!_isEditMode ||
        widget.reservation == null ||
        widget.reservation!.user == null) {
      return null;
    }

    final reservationUserId = widget.reservation!.user!.id.toString();

    debugPrint('DEBUG: _initialUserValue called');
    debugPrint('DEBUG: reservationUserId = $reservationUserId');
    debugPrint('DEBUG: returning = $reservationUserId');

    return reservationUserId;
  }

  String? get _initialNotesValue {
    if (!_isEditMode || widget.reservation == null) {
      return null;
    }

    return widget.reservation!.notes;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMenus();
      _loadUsers();

      // If in edit mode, try to populate form immediately
      // This handles the case where menus/customers might already be loaded
      if (_isEditMode) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _tryPopulateForm();
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Don't manually dispose form fields as FormBuilder handles this
    // Manual disposal can cause issues if the widget is already being disposed
    super.dispose();
  }

  Future<void> _loadMenus() async {
    if (_isDisposed) return;

    if (mounted) {
      setState(() {
        _isLoadingMenus = true;
      });
    }

    try {
      // Load available menus from provider
      await ref
          .read(adminMenuGetNotifierProvider.notifier)
          .getInitialAdminMenus();
      final menuState = ref.read(adminMenuGetNotifierProvider);

      if (mounted && !_isDisposed) {
        setState(() {
          _availableMenus = menuState.menus;
          _isLoadingMenus = false;
        });
      }

      debugPrint('DEBUG: Menus loaded, count = ${menuState.menus.length}');
      debugPrint(
        'DEBUG: Available menu IDs: ${menuState.menus.map((m) => m.id).toList()}',
      );
      if (_isEditMode && widget.reservation != null) {
        debugPrint(
          'DEBUG: Current reservation menu ID: ${widget.reservation!.menu.id}',
        );
        debugPrint(
          'DEBUG: Current reservation menu name: ${widget.reservation!.menu.name}',
        );
      }

      // Check if both menus and customers are loaded before populating form
      _tryPopulateForm();
    } catch (e) {
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoadingMenus = false;
        });
      }
    }
  }

  Future<void> _loadUsers() async {
    if (_isDisposed) return;

    if (mounted) {
      setState(() {
        _isLoadingUsers = true;
      });
    }

    try {
      // Load available users from search provider
      await ref
          .read(usersSearchNotifierProvider.notifier)
          .searchUsers(search: '');
      final userState = ref.read(usersSearchNotifierProvider);

      if (mounted && !_isDisposed) {
        setState(() {
          _availableUsers = userState.users;
          _isLoadingUsers = false;
        });
      }

      debugPrint('DEBUG: Users loaded, count = ${userState.users.length}');
      debugPrint(
        'DEBUG: Available user IDs: ${userState.users.map((u) => u.id).toList()}',
      );
      if (_isEditMode && widget.reservation?.user != null) {
        debugPrint(
          'DEBUG: Current reservation user ID: ${widget.reservation!.user!.id}',
        );
      }

      // Check if both menus and users are loaded before populating form
      _tryPopulateForm();
    } catch (e) {
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoadingUsers = false;
        });
      }
    }
  }

  void _tryPopulateForm() {
    // Only populate form if we're in edit mode, haven't populated yet,
    // and both menus and users are loaded
    if (_isEditMode &&
        !_hasPopulatedForm &&
        !_isLoadingMenus &&
        !_isLoadingUsers &&
        !_isDisposed &&
        widget.reservation != null) {
      debugPrint('DEBUG: All data loaded, populating form');
      _populateForm();
      _hasPopulatedForm = true;
    }
  }

  void _populateForm() {
    if (_isDisposed || widget.reservation == null) return;

    final reservation = widget.reservation!;
    debugPrint('DEBUG: Populating form with reservation data');
    debugPrint('DEBUG: Reservation ID: ${reservation.id}');
    debugPrint('DEBUG: Menu ID: ${reservation.menu.id}');
    debugPrint('DEBUG: User ID: ${reservation.user?.id}');
    debugPrint(
      'DEBUG: Reservation datetime: ${reservation.reservationDatetime}',
    );

    // Use Future.delayed to ensure form is fully built before patching values
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_formKey.currentState != null && mounted && !_isDisposed) {
        debugPrint('DEBUG: Patching form values');
        _formKey.currentState?.patchValue({
          // Don't set menu_id and customer_id here, let initialValue handle them
          'reservation_datetime': DateFormat(
            'yyyy-MM-dd HH:mm',
          ).format(reservation.reservationDatetime),
          'number_of_people': reservation.numberOfPeople.toString(),
          'amount': reservation.amount.raw,
          'status': reservation.status.value.name,
          'notes': reservation.notes ?? '',
        });

        debugPrint('DEBUG: Form values patched successfully');
      } else {
        debugPrint('DEBUG: Form state is null or widget disposed');
      }
    });
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting || !mounted) return;

    setState(() {
      _validationErrors = null;
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final notifier = ref.read(reservationMutationNotifierProvider.notifier);

      final menuId = int.parse(values['menu_id'] as String);
      final userId = values['user_id'] as String?;
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

        // Only update with userId if a new user is selected
        // If no user is selected in the form, don't try to update with the old user ID
        final selectedUserId = userId != null ? int.tryParse(userId) : null;

        notifier.updateReservation(
          UpdateReservationParams(
            id: widget.reservation!.id,
            reservationNumber: widget.reservation!.reservationNumber,
            userId: selectedUserId,
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
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        AppToast.showError(
          context,
          message: 'Please correct the errors in the form.',
        );
      }
    }
  }

  void _showDeleteConfirmationDialog() {
    if (!mounted) return;

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
                if (mounted) {
                  final notifier = ref.read(
                    reservationMutationNotifierProvider.notifier,
                  );
                  notifier.deleteReservation(id: widget.reservation!.id);
                }
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
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }

      if (next.status == ReservationMutationStatus.success) {
        if (mounted) {
          AppToast.showSuccess(
            context,
            message:
                next.successMessage ??
                (_isEditMode
                    ? 'Reservation updated successfully'
                    : 'Reservation created successfully'),
          );
          context.router.pop();
        }
      } else if (next.status == ReservationMutationStatus.error &&
          next.failure != null) {
        if (mounted) {
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
        const AppText('User Information', style: AppTextStyle.titleMedium),
        const SizedBox(height: 16),
        // User Selection Dropdown
        AppSearchableDropdown<String>(
          key: ValueKey(
            'user_searchable_dropdown_${widget.reservation?.id ?? "new"}',
          ),
          name: 'user_id',
          label: 'User (Optional)',
          hintText:
              'Search and select a user or leave empty to remove user association',
          initialValue: _initialUserValue,
          items: _availableUsers
              .map(
                (user) => AppSearchableDropdownItem<String>(
                  value: user.id.toString(),
                  label: '${user.fullName} (${user.email})',
                  searchKey:
                      '${user.fullName} ${user.fullNameKana} ${user.email} ${user.phoneNumber}',
                ),
              )
              .toList(),
          onSearch: (query) async {
            await ref
                .read(usersSearchNotifierProvider.notifier)
                .searchUsers(search: query);
            final userState = ref.read(usersSearchNotifierProvider);

            return userState.users
                .map(
                  (user) => AppSearchableDropdownItem<String>(
                    value: user.id.toString(),
                    label: '${user.fullName} (${user.email})',
                    searchKey:
                        '${user.fullName} ${user.fullNameKana} ${user.email} ${user.phoneNumber}',
                  ),
                )
                .toList();
          },
          onLoadMore: () async {
            final userState = ref.read(usersSearchNotifierProvider);
            await ref
                .read(usersSearchNotifierProvider.notifier)
                .loadMoreSearchResults(search: '');
            final updatedState = ref.read(usersSearchNotifierProvider);

            final currentUsers = userState.users.map((u) => u.id).toSet();
            final newUsers = updatedState.users
                .where((u) => !currentUsers.contains(u.id))
                .toList();

            return newUsers
                .map(
                  (user) => AppSearchableDropdownItem<String>(
                    value: user.id.toString(),
                    label: '${user.fullName} (${user.email})',
                    searchKey:
                        '${user.fullName} ${user.fullNameKana} ${user.email} ${user.phoneNumber}',
                  ),
                )
                .toList();
          },
          enableInfiniteScroll: true,
          validator: (value) {
            // User is now optional, so no validation required
            return null;
          },
        ),
        const SizedBox(height: 16),
        if (_isEditMode && widget.reservation?.customerInfo != null)
          // Show existing user info for edit mode
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
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
              ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
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
                const AppText(
                  'New Reservation',
                  style: AppTextStyle.bodyMedium,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                const AppText(
                  'User information will be collected during reservation process',
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
        AppSearchableDropdown<String>(
          key: ValueKey(
            'menu_searchable_dropdown_${widget.reservation?.id ?? "new"}',
          ),
          name: 'menu_id',
          label: 'Menu',
          hintText: 'Search and select a menu',
          initialValue: _initialMenuValue,
          items: _availableMenus
              .map(
                (menu) => AppSearchableDropdownItem<String>(
                  value: menu.id.toString(),
                  label: menu.name,
                  searchKey: '${menu.name} ${menu.description ?? ''}',
                ),
              )
              .toList(),
          onSearch: (query) async {
            await ref
                .read(adminMenusSearchNotifierProvider.notifier)
                .searchAdminMenus(search: query);
            final menuState = ref.read(adminMenusSearchNotifierProvider);

            return menuState.menus
                .map(
                  (menu) => AppSearchableDropdownItem<String>(
                    value: menu.id.toString(),
                    label: menu.name,
                    searchKey: '${menu.name} ${menu.description ?? ''}',
                  ),
                )
                .toList();
          },
          onLoadMore: () async {
            final menuState = ref.read(adminMenusSearchNotifierProvider);
            await ref
                .read(adminMenusSearchNotifierProvider.notifier)
                .loadMoreSearchResults(search: '');
            final updatedState = ref.read(adminMenusSearchNotifierProvider);

            final currentMenus = menuState.menus.map((m) => m.id).toSet();
            final newMenus = updatedState.menus
                .where((m) => !currentMenus.contains(m.id))
                .toList();

            return newMenus
                .map(
                  (menu) => AppSearchableDropdownItem<String>(
                    value: menu.id.toString(),
                    label: menu.name,
                    searchKey: '${menu.name} ${menu.description ?? ''}',
                  ),
                )
                .toList();
          },
          enableInfiniteScroll: true,
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
          initialValue: _isEditMode && widget.reservation != null
              ? DateFormat(
                  'yyyy-MM-dd HH:mm',
                ).format(widget.reservation!.reservationDatetime)
              : null,
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
                initialValue: _isEditMode && widget.reservation != null
                    ? widget.reservation!.numberOfPeople.toString()
                    : null,
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
                initialValue: _isEditMode && widget.reservation != null
                    ? widget.reservation!.amount.raw
                    : null,
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Additional Information', style: AppTextStyle.titleMedium),
        SizedBox(height: 16),
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
