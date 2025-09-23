import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/delete_announcement_usecase.dart';
import 'package:tires/features/announcement/domain/usecases/update_announcement_usecase.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_mutation_state.dart';
import 'package:tires/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:tires/features/announcement/presentation/validations/announcement_validators.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_date_time_picker.dart';
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminUpsertAnnouncementScreen extends ConsumerStatefulWidget {
  final Announcement? announcement;

  const AdminUpsertAnnouncementScreen({super.key, this.announcement});

  @override
  ConsumerState<AdminUpsertAnnouncementScreen> createState() =>
      _AdminUpsertAnnouncementScreenState();
}

class _AdminUpsertAnnouncementScreenState
    extends ConsumerState<AdminUpsertAnnouncementScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;

  bool get _isEditMode => widget.announcement != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _populateForm();
      });
    }
  }

  void _populateForm() {
    final announcement = widget.announcement;
    if (announcement != null) {
      _formKey.currentState?.patchValue({
        'title_en': announcement.translations?.en.title,
        'content_en': announcement.translations?.en.content,
        'title_ja': announcement.translations?.ja.title,
        'content_ja': announcement.translations?.ja.content,
        'published_at': announcement.publishedAt,
        'is_active': announcement.isActive,
      });
      // Force rebuild to ensure form fields are updated
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
      final notifier = ref.read(announcementMutationNotifierProvider.notifier);

      final titleEn = values['title_en'] as String;
      final contentEn = values['content_en'] as String;
      final titleJa = values['title_ja'] as String?;
      final contentJa = values['content_ja'] as String?;
      final publishedAt = values['published_at'] as DateTime?;
      final isActive = values['is_active'] as bool;

      if (_isEditMode) {
        notifier.updateAnnouncement(
          UpdateAnnouncementParams(
            id: widget.announcement!.id,
            translations: AnnouncementTranslation(
              en: AnnouncementContent(title: titleEn, content: contentEn),
              ja: AnnouncementContent(
                title: titleJa ?? '',
                content: contentJa ?? '',
              ),
            ),
            publishedAt: publishedAt,
            isActive: isActive,
          ),
        );
      } else {
        notifier.createAnnouncement(
          CreateAnnouncementParams(
            translations: AnnouncementTranslation(
              en: AnnouncementContent(title: titleEn, content: contentEn),
              ja: AnnouncementContent(
                title: titleJa ?? '',
                content: contentJa ?? '',
              ),
            ),
            publishedAt: publishedAt ?? DateTime.now(),
            isActive: isActive,
          ),
        );
      }
    } else {
      setState(() {
        _isSubmitting = false;
      });
      AppToast.showError(
        context,
        message: context.l10n.announcementNotificationInvalidData,
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
            context.l10n.adminUpsertAnnouncementScreenDeleteModalTitle,
          ),
          content: AppText(
            context.l10n.adminUpsertAnnouncementScreenDeleteModalContent,
          ),
          actions: [
            AppButton(
              text: context
                  .l10n
                  .adminUpsertAnnouncementScreenDeleteModalCancelButton,
              onPressed: () => Navigator.of(context).pop(),
              variant: AppButtonVariant.outlined,
              color: AppButtonColor.neutral,
              isFullWidth: false,
            ),
            const SizedBox(width: 8),
            AppButton(
              text: context
                  .l10n
                  .adminUpsertAnnouncementScreenDeleteModalDeleteButton,
              onPressed: () {
                Navigator.of(context).pop();
                final notifier = ref.read(
                  announcementMutationNotifierProvider.notifier,
                );
                notifier.deleteAnnouncement(
                  DeleteAnnouncementParams(widget.announcement!.id),
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

    ref.listen(announcementMutationNotifierProvider, (previous, next) {
      if (next.status != AnnouncementMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == AnnouncementMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message:
              next.successMessage ??
              (_isEditMode
                  ? context.l10n.announcementNotificationUpdated
                  : context.l10n.announcementNotificationCreated),
        );
        context.router.pop();
      } else if (next.status == AnnouncementMutationStatus.error &&
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

    final mutationState = ref.watch(announcementMutationNotifierProvider);
    final isLoading =
        mutationState.status == AnnouncementMutationStatus.loading;

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ScreenWrapper(
          child: SingleChildScrollView(
            child: Column(
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
              ? l10n.adminUpsertAnnouncementScreenEditTitle
              : l10n.adminUpsertAnnouncementScreenPageTitle,
          style: AppTextStyle.headlineSmall,
        ),
        const SizedBox(height: 4),
        AppText(
          _isEditMode
              ? l10n.adminUpsertAnnouncementScreenEditSubtitle
              : l10n.adminUpsertAnnouncementScreenFormSectionDescription,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    l10n.adminUpsertAnnouncementScreenFormSectionTitle,
                    style: AppTextStyle.titleLarge,
                  ),
                  AppText(
                    l10n.adminUpsertAnnouncementScreenFormSectionDescription,
                    style: AppTextStyle.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  _buildEnglishSection(l10n),
                  const SizedBox(height: 24),
                  _buildJapaneseSection(l10n),
                  const SizedBox(height: 24),
                  _buildCommonSettings(l10n),
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

  Widget _buildEnglishSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertAnnouncementScreenEnSectionTitle,
          style: AppTextStyle.titleMedium,
        ),
        AppText(
          l10n.adminUpsertAnnouncementScreenEnSectionDescription,
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'title_en',
          label: l10n.adminUpsertAnnouncementScreenEnTitleLabel,
          placeHolder: l10n.adminUpsertAnnouncementScreenEnTitlePlaceholder,
          validator: AnnouncementValidators.title(context),
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'content_en',
          label: l10n.adminUpsertAnnouncementScreenEnContentLabel,
          placeHolder: l10n.adminUpsertAnnouncementScreenEnContentPlaceholder,
          validator: AnnouncementValidators.content(context),
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _buildJapaneseSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertAnnouncementScreenJaSectionTitle,
          style: AppTextStyle.titleMedium,
        ),
        AppText(
          l10n.adminUpsertAnnouncementScreenJaSectionDescription,
          style: AppTextStyle.bodySmall,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'title_ja',
          label: l10n.adminUpsertAnnouncementScreenJaTitleLabel,
          placeHolder: l10n.adminUpsertAnnouncementScreenJaTitlePlaceholder,
          validator: FormBuilderValidators.maxLength(255),
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'content_ja',
          label: l10n.adminUpsertAnnouncementScreenJaContentLabel,
          placeHolder: l10n.adminUpsertAnnouncementScreenJaContentPlaceholder,
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _buildCommonSettings(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          l10n.adminUpsertAnnouncementScreenCommonSettingsTitle,
          style: AppTextStyle.titleMedium,
        ),
        const SizedBox(height: 16),
        AppDateTimePicker(
          name: 'published_at',
          label: l10n.adminUpsertAnnouncementScreenPublishedAtLabel,
        ),
        const SizedBox(height: 16),
        AppRadioGroup<bool>(
          name: 'is_active',
          label: l10n.adminUpsertAnnouncementScreenStatusLabel,
          options: [
            FormBuilderFieldOption(
              value: true,
              child: Text(l10n.adminUpsertAnnouncementScreenStatusActive),
            ),
            FormBuilderFieldOption(
              value: false,
              child: Text(l10n.adminUpsertAnnouncementScreenStatusInactive),
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
            text: context
                .l10n
                .adminUpsertAnnouncementScreenDeleteModalDeleteButton,
            onPressed: _showDeleteConfirmationDialog,
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.error,
            isFullWidth: false,
          )
        else
          AppButton(
            text: l10n.adminUpsertAnnouncementScreenCancelButton,
            onPressed: () => context.router.pop(),
            variant: AppButtonVariant.outlined,
            color: AppButtonColor.neutral,
            isFullWidth: false,
          ),
        const SizedBox(width: 16),
        AppButton(
          text: _isEditMode
              ? l10n.adminUpsertAnnouncementScreenFormButtonsUpdate
              : l10n.adminUpsertAnnouncementScreenSaveButton,
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
