import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';
import 'package:tires/features/announcement/domain/usecases/create_announcement_usecase.dart';
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
    extends ConsumerState<AdminUpsertAnnouncementScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;
  late TabController _tabController;
  bool _showPreview = false;
  late ValueNotifier<Map<String, dynamic>> _formValues;

  bool get _isEditMode => widget.announcement != null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _formValues = ValueNotifier({});
    if (_isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _populateForm();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _formValues.dispose();
    super.dispose();
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
      // Update form values for preview
      _formValues.value = _formKey.currentState?.value ?? {};
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
            translation: AnnouncementTranslation(
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
        message: 'Please correct the errors in the form.',
      );
    }
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
                  ? 'Announcement updated successfully'
                  : 'Announcement created successfully'),
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
      onChanged: () {
        _formValues.value = _formKey.currentState?.value ?? {};
      },
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
                  _buildLanguageTabs(l10n),
                  const SizedBox(height: 16),
                  _buildLanguageSections(l10n),
                  const SizedBox(height: 24),
                  _buildCommonSettings(l10n),
                  const SizedBox(height: 24),
                  _buildPreviewSection(l10n),
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

  Widget _buildLanguageTabs(L10n l10n) {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: l10n.adminUpsertAnnouncementScreenTabEnglish),
        Tab(text: l10n.adminUpsertAnnouncementScreenTabJapanese),
      ],
    );
  }

  Widget _buildLanguageSections(L10n l10n) {
    return SizedBox(
      height: 450,
      child: TabBarView(
        controller: _tabController,
        children: [_buildEnglishSection(l10n), _buildJapaneseSection(l10n)],
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

  Widget _buildPreviewSection(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              l10n.adminUpsertAnnouncementScreenPreviewTitle,
              style: AppTextStyle.titleMedium,
            ),
            Switch(
              value: _showPreview,
              onChanged: (value) {
                setState(() {
                  _showPreview = value;
                });
              },
            ),
          ],
        ),
        if (_showPreview) ...[
          const SizedBox(height: 8),
          _buildPreviewContent(l10n),
        ],
      ],
    );
  }

  Widget _buildPreviewContent(L10n l10n) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: _formValues,
      builder: (context, values, child) {
        final titleEn =
            values['title_en'] as String? ??
            l10n.adminUpsertAnnouncementScreenPreviewTitlePlaceholder;
        final contentEn =
            values['content_en'] as String? ??
            l10n.adminUpsertAnnouncementScreenPreviewContentPlaceholder;
        final publishedAt = values['published_at'] as DateTime?;
        final isActive = values['is_active'] as bool?;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(titleEn, style: AppTextStyle.titleMedium),
                const SizedBox(height: 8),
                AppText(contentEn, style: AppTextStyle.bodyMedium),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 4),
                    AppText(
                      publishedAt != null
                          ? '${publishedAt.toLocal()}'.split(' ')[0]
                          : l10n.adminUpsertAnnouncementScreenPreviewDateNotSelected,
                      style: AppTextStyle.bodySmall,
                    ),
                    const SizedBox(width: 16),
                    Chip(
                      label: AppText(
                        isActive == true
                            ? l10n.adminUpsertAnnouncementScreenStatusActive
                            : l10n.adminUpsertAnnouncementScreenStatusInactive,
                        style: AppTextStyle.labelSmall,
                      ),
                      backgroundColor: isActive == true
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(L10n l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
