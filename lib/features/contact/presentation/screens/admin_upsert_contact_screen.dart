import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/contact/domain/usecases/delete_contact_usecase.dart';
import 'package:tires/features/contact/domain/usecases/update_contact_usecase.dart';
import 'package:tires/features/contact/presentation/providers/contact_mutation_state.dart';
import 'package:tires/features/contact/presentation/providers/contact_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminUpsertContactScreen extends ConsumerStatefulWidget {
  final Contact? contact;

  const AdminUpsertContactScreen({super.key, this.contact});

  @override
  ConsumerState<AdminUpsertContactScreen> createState() =>
      _AdminUpsertContactScreenState();
}

class _AdminUpsertContactScreenState
    extends ConsumerState<AdminUpsertContactScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;

  bool get _isEditMode => widget.contact != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _populateForm();
      });
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.fields.forEach((key, field) {
      field.dispose();
    });
    super.dispose();
  }

  void _populateForm() {
    final contact = widget.contact;
    if (contact != null) {
      _formKey.currentState?.patchValue({
        'admin_reply': contact.adminReply ?? '',
        'status': contact.status,
      });
      setState(() {});
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
      final notifier = ref.read(contactMutationNotifierProvider.notifier);

      final adminReply = values['admin_reply'] as String?;
      final status = values['status'] as ContactStatus;

      if (_isEditMode) {
        notifier.updateContact(
          UpdateContactParams(
            id: widget.contact!.id,
            adminReply: adminReply?.isEmpty ?? true ? null : adminReply,
            status: status,
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
          title: AppText(context.l10n.adminUpsertContactScreenDeleteModalTitle),
          content: AppText(
            context.l10n.adminUpsertContactScreenDeleteModalText,
          ),
          actions: [
            AppButton(
              text: context.l10n.adminUpsertContactScreenButtonsCancel,
              onPressed: () => Navigator.of(context).pop(),
              variant: AppButtonVariant.outlined,
              color: AppButtonColor.neutral,
              isFullWidth: false,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: context.l10n.adminUpsertContactScreenButtonsDelete,
              onPressed: () {
                Navigator.of(context).pop();
                final notifier = ref.read(
                  contactMutationNotifierProvider.notifier,
                );
                notifier.deleteContact(DeleteContactParams(widget.contact!.id));
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

  void _markAsReplied() {
    _formKey.currentState?.patchValue({'status': ContactStatus.replied});
  }

  void _markAsPending() {
    _formKey.currentState?.patchValue({'status': ContactStatus.pending});
  }

  void _setDefaultReply() {
    final l10n = context.l10n;
    _formKey.currentState?.patchValue({
      'admin_reply': l10n.adminUpsertContactScreenQuickActionsDefaultReply,
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    ref.listen(contactMutationNotifierProvider, (previous, next) {
      if (next.status != ContactMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == ContactMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message: next.successMessage ?? l10n.contactNotificationUpdated,
        );
        context.router.pop();
      } else if (next.status == ContactMutationStatus.error &&
          next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          AppToast.showError(context, message: next.failure!.message);
        }
      }
    });

    final mutationState = ref.watch(contactMutationNotifierProvider);
    final isLoading = mutationState.status == ContactMutationStatus.loading;

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
          l10n.adminUpsertContactScreenPageTitle,
          style: AppTextStyle.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 4),
        AppText(
          l10n.adminUpsertContactScreenPageSubtitle,
          style: AppTextStyle.bodyMedium,
          softWrap: true,
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
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
          _buildContactInfoCard(l10n),
          const SizedBox(height: 24),
          _buildQuickActionsCard(l10n),
          const SizedBox(height: 24),
          _buildUpdateContactCard(l10n),
          const SizedBox(height: 24),
          _buildActionButtons(l10n),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard(L10n l10n) {
    final contact = widget.contact;
    if (contact == null) return const SizedBox.shrink();

    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              l10n.adminUpsertContactScreenCardContactInfo,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            if (contact.user != null) ...[
              _buildInfoRow(
                icon: Icons.person_outline,
                label: 'User',
                value: contact.user!.fullName,
              ),
              const SizedBox(height: 12),
            ],
            if (contact.fullName != null) ...[
              _buildInfoRow(
                icon: Icons.person_outline,
                label: 'Full Name',
                value: contact.fullName!,
              ),
              const SizedBox(height: 12),
            ],
            if (contact.email != null) ...[
              _buildInfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: contact.email!,
              ),
              const SizedBox(height: 12),
            ],
            if (contact.phoneNumber != null) ...[
              _buildInfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: contact.phoneNumber!,
              ),
              const SizedBox(height: 12),
            ],
            _buildInfoRow(
              icon: Icons.subject_outlined,
              label: l10n.adminUpsertContactScreenLabelsSubject,
              value: contact.subject,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            AppText(
              l10n.adminUpsertContactScreenLabelsMessage,
              style: AppTextStyle.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppText(contact.message, style: AppTextStyle.bodyLarge),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Created At',
                    value: dateFormat.format(contact.createdAt),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoRow(
                    icon: Icons.update_outlined,
                    label: 'Updated At',
                    value: dateFormat.format(contact.updatedAt),
                  ),
                ),
              ],
            ),
            if (contact.repliedAt != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                icon: Icons.check_circle_outline,
                label: 'Replied At',
                value: dateFormat.format(contact.repliedAt!),
              ),
            ],
            const SizedBox(height: 16),
            Chip(
              avatar: Icon(
                contact.status == ContactStatus.replied
                    ? Icons.check_circle
                    : Icons.pending,
                color: contact.status == ContactStatus.replied
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
                size: 16,
              ),
              label: AppText(
                contact.status == ContactStatus.replied
                    ? l10n.adminUpsertContactScreenStatusReplied
                    : l10n.adminUpsertContactScreenStatusPending,
                style: AppTextStyle.labelMedium,
              ),
              backgroundColor: contact.status == ContactStatus.replied
                  ? Colors.green.shade100
                  : Colors.orange.shade100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard(L10n l10n) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              l10n.adminUpsertContactScreenCardQuickActions,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AppButton(
                  text: l10n.adminUpsertContactScreenQuickActionsMarkAsReplied,
                  onPressed: _markAsReplied,
                  variant: AppButtonVariant.outlined,
                  color: AppButtonColor.success,
                  isFullWidth: false,
                  leadingIcon: const Icon(Icons.check_circle_outline, size: 18),
                ),
                AppButton(
                  text: l10n.adminUpsertContactScreenQuickActionsMarkAsPending,
                  onPressed: _markAsPending,
                  variant: AppButtonVariant.outlined,
                  color: AppButtonColor.warning,
                  isFullWidth: false,
                  leadingIcon: const Icon(Icons.pending_outlined, size: 18),
                ),
                AppButton(
                  text: 'Set Default Reply',
                  onPressed: _setDefaultReply,
                  variant: AppButtonVariant.outlined,
                  color: AppButtonColor.neutral,
                  isFullWidth: false,
                  leadingIcon: const Icon(Icons.auto_fix_high, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateContactCard(L10n l10n) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              l10n.adminUpsertContactScreenCardUpdateContact,
              style: AppTextStyle.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  name: 'admin_reply',
                  label: l10n.adminUpsertContactScreenLabelsAdminReply,
                  placeHolder:
                      l10n.adminUpsertContactScreenFormReplyPlaceholder,
                  type: AppTextFieldType.multiline,
                  maxLines: 8,
                ),
                const SizedBox(height: 4),
                AppText(
                  l10n.adminUpsertContactScreenFormReplyHelpText,
                  style: AppTextStyle.bodySmall,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppRadioGroup<ContactStatus>(
              name: 'status',
              label: l10n.adminUpsertContactScreenLabelsStatus,
              options: [
                FormBuilderFieldOption(
                  value: ContactStatus.pending,
                  child: Row(
                    children: [
                      Icon(
                        Icons.pending,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        l10n.adminUpsertContactScreenStatusPending,
                        style: AppTextStyle.bodyLarge,
                      ),
                    ],
                  ),
                ),
                FormBuilderFieldOption(
                  value: ContactStatus.replied,
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        l10n.adminUpsertContactScreenStatusReplied,
                        style: AppTextStyle.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                label,
                style: AppTextStyle.labelMedium,
                color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 2),
              AppText(
                value.isNotEmpty ? value : 'N/A',
                style: AppTextStyle.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
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
            text: l10n.adminUpsertContactScreenButtonsDelete,
            onPressed: _showDeleteConfirmationDialog,
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.error,
            isFullWidth: false,
          )
        else
          AppButton(
            text: l10n.adminUpsertContactScreenButtonsBackToList,
            onPressed: () => context.router.pop(),
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.neutral,
            isFullWidth: false,
          ),
        const SizedBox(width: 16),
        AppButton(
          text: l10n.adminUpsertContactScreenButtonsUpdate,
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
