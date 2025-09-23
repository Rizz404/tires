import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_rich_text_editor.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/app_time_picker.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminEditBusinessInformationScreen extends ConsumerStatefulWidget {
  final BusinessInformation businessInformation;

  const AdminEditBusinessInformationScreen({
    super.key,
    required this.businessInformation,
  });

  @override
  ConsumerState<AdminEditBusinessInformationScreen> createState() =>
      _AdminEditBusinessInformationScreenState();
}

class _AdminEditBusinessInformationScreenState
    extends ConsumerState<AdminEditBusinessInformationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateForm();
    });
  }

  void _populateForm() {
    final businessInfo = widget.businessInformation;
    final Map<String, dynamic> formValues = {
      'shop_name': businessInfo.shopName,
      'phone_number': businessInfo.phoneNumber,
      'address': businessInfo.address,
      'website_url': businessInfo.websiteUrl,
      'site_name': businessInfo.siteName,
      'site_public': businessInfo.sitePublic,
      'reply_email': businessInfo.replyEmail,
      'google_analytics_id': businessInfo.googleAnalyticsId,
      'shop_description': businessInfo.shopDescription,
      'access_information': businessInfo.accessInformation,
      'terms_of_use': businessInfo.termsOfUse,
      'privacy_policy': businessInfo.privacyPolicy,
    };

    // Add business hours mapping
    final businessHours = businessInfo.businessHours;
    final days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    for (final day in days) {
      final dayData = businessHours[day] as Map<String, dynamic>?;
      if (dayData != null) {
        formValues['${day}_closed'] = dayData['closed'] ?? false;
        formValues['${day}_open_time'] = dayData['open'];
        formValues['${day}_close_time'] = dayData['close'];
      } else {
        formValues['${day}_closed'] = false;
      }
    }

    _formKey.currentState?.patchValue(formValues);
    // Force rebuild to ensure form fields are updated
    setState(() {});
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting) return;

    setState(() {
      _validationErrors = null;
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      // TODO: Implement business information update logic with provider
      // This will be implemented when providers are available
      print('Form values: $values');

      // Simulate successful update for now
      setState(() {
        _isSubmitting = false;
      });

      AppToast.showSuccess(
        context,
        message: 'Business information updated successfully',
      );
      context.router.pop();
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

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: LoadingOverlay(
        isLoading: _isSubmitting,
        child: ScreenWrapper(
          child: FormBuilder(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(l10n)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                if (_validationErrors != null)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        ErrorSummaryBox(errors: _validationErrors!),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                SliverToBoxAdapter(child: _buildBasicInformation()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildBusinessHours()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildSiteSettings()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildDescriptionAndImage()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildPoliciesAndTerms()),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(child: _buildActionButtons(l10n)),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
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
          l10n.adminUpsertBusinessInformationScreenPageTitle,
          style: AppTextStyle.headlineMedium,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 4),
        AppText(
          l10n.adminUpsertBusinessInformationScreenPageSubtitle,
          style: AppTextStyle.bodyLarge,
          color: context.colorScheme.onSurface.withOpacity(0.7),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(icon, size: 22),
                const SizedBox(width: 12),
                AppText(
                  title,
                  style: AppTextStyle.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformation() {
    return _buildSection(
      title: "Basic Information",
      icon: Icons.storefront,
      children: [
        AppTextField(
          name: 'shop_name',
          label:
              context.l10n.adminUpsertBusinessInformationScreenLabelsShopName,
          validator: FormBuilderValidators.required(),
          type: AppTextFieldType.text,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'phone_number',
          label: context
              .l10n
              .adminUpsertBusinessInformationScreenLabelsPhoneNumber,
          validator: FormBuilderValidators.required(),
          type: AppTextFieldType.phone,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'address',
          label: context.l10n.adminUpsertBusinessInformationScreenLabelsAddress,
          validator: FormBuilderValidators.required(),
          type: AppTextFieldType.multiline,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'website_url',
          label:
              context.l10n.adminUpsertBusinessInformationScreenLabelsWebsiteUrl,
          validator: FormBuilderValidators.url(),
          type: AppTextFieldType.url,
        ),
      ],
    );
  }

  Widget _buildBusinessHours() {
    return _buildSection(
      title: "Business Hours",
      icon: Icons.access_time_filled,
      children: [
        _buildDayBusinessHours('monday', "Monday"),
        _buildDayBusinessHours('tuesday', "Tuesday"),
        _buildDayBusinessHours('wednesday', "Wednesday"),
        _buildDayBusinessHours('thursday', "Thursday"),
        _buildDayBusinessHours('friday', "Friday"),
        _buildDayBusinessHours('saturday', "Saturday"),
        _buildDayBusinessHours('sunday', "Sunday"),
      ],
    );
  }

  Widget _buildDayBusinessHours(String day, String dayLabel) {
    return FormBuilderField<bool>(
      name: '${day}_closed',
      initialValue: false,
      builder: (field) {
        final isClosed = field.value ?? false;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(dayLabel, style: AppTextStyle.titleMedium),
                  ),
                  // Use regular Checkbox to avoid duplicate field registration
                  SizedBox(
                    width: 120, // Fixed width for the checkbox
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isClosed,
                          onChanged: (value) {
                            field.didChange(value);
                            setState(
                              () {},
                            ); // Rebuild to update time picker state
                          },
                        ),
                        const Text("Closed"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppTimePicker(
                      name: '${day}_open_time',
                      label: context
                          .l10n
                          .adminUpsertBusinessInformationScreenLabelsOpenTime,
                      enabled: !isClosed,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTimePicker(
                      name: '${day}_close_time',
                      label: context
                          .l10n
                          .adminUpsertBusinessInformationScreenLabelsCloseTime,
                      enabled: !isClosed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSiteSettings() {
    return _buildSection(
      title: "Site Settings",
      icon: Icons.language,
      children: [
        AppTextField(
          name: 'site_name',
          label:
              context.l10n.adminUpsertBusinessInformationScreenLabelsSiteName,
          validator: FormBuilderValidators.required(),
        ),
        const SizedBox(height: 16),
        AppCheckbox(
          name: 'site_public',
          title: AppText(
            context
                .l10n
                .adminUpsertBusinessInformationScreenLabelsMakeSitePublic,
          ),
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'reply_email',
          label:
              context.l10n.adminUpsertBusinessInformationScreenLabelsReplyEmail,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const SizedBox(height: 16),
        const AppTextField(
          name: 'google_analytics_id',
          label: "Google Analytics ID",
        ),
      ],
    );
  }

  Widget _buildDescriptionAndImage() {
    return _buildSection(
      title: "Description & Image",
      icon: Icons.image,
      children: [
        const AppTextField(
          name: 'shop_description',
          label: "Shop Description",
          maxLines: 5,
        ),
        const SizedBox(height: 16),
        const AppTextField(
          name: 'access_information',
          label: "Access Information",
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        // TODO: Add image picker
        AppText(
          '${context.l10n.adminUpsertBusinessInformationScreenLabelsTopImage} (Image Picker to be implemented)',
        ),
      ],
    );
  }

  Widget _buildPoliciesAndTerms() {
    return _buildSection(
      title: "Policies & Terms",
      icon: Icons.policy,
      children: [
        const AppRichTextEditor(name: 'terms_of_use', label: "Terms of Use"),
        const SizedBox(height: 16),
        const AppRichTextEditor(
          name: 'privacy_policy',
          label: "Privacy Policy",
        ),
      ],
    );
  }

  Widget _buildActionButtons(L10n l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          text: l10n.adminUpsertBusinessInformationScreenButtonsCancel,
          onPressed: () => context.router.pop(),
          variant: AppButtonVariant.outlined,
          color: AppButtonColor.neutral,
          isFullWidth: false,
        ),
        const SizedBox(width: 16),
        AppButton(
          text: l10n.adminUpsertBusinessInformationScreenButtonsSaveChanges,
          onPressed: () => _handleSubmit(ref),
          isLoading: _isSubmitting,
          isFullWidth: false,
        ),
      ],
    );
  }
}
