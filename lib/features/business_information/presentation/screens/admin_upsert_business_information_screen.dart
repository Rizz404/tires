import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_rich_text_editor.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/app_time_picker.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminUpsertBusinessInformationScreen extends ConsumerStatefulWidget {
  final BusinessInformation? businessInformation;

  const AdminUpsertBusinessInformationScreen({
    super.key,
    this.businessInformation,
  });

  @override
  ConsumerState<AdminUpsertBusinessInformationScreen> createState() =>
      _AdminUpsertBusinessInformationScreenState();
}

class _AdminUpsertBusinessInformationScreenState
    extends ConsumerState<AdminUpsertBusinessInformationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool get _isEditMode => widget.businessInformation != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      // TODO: Populate form with businessInformation data
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // TODO: Handle form submission
      final values = _formKey.currentState!.value;
      print(values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: FormBuilder(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
              SliverToBoxAdapter(child: _buildActionButtons()),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          _isEditMode ? "Edit Business Settings" : "Create Business Settings",
          style: AppTextStyle.headlineMedium,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 4),
        AppText(
          "Update your business information and operating hours",
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
          label: "Shop Name",
          validator: FormBuilderValidators.required(),
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'phone_number',
          label: "Phone Number",
          validator: FormBuilderValidators.required(),
          type: AppTextFieldType.phone,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'address',
          label: "Address",
          validator: FormBuilderValidators.required(),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        AppTextField(
          name: 'website_url',
          label: "Website URL",
          validator: FormBuilderValidators.url(),
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
                  // Correctly use FormBuilderCheckbox within the builder
                  SizedBox(
                    width: 120, // Fixed width for the checkbox
                    child: FormBuilderCheckbox(
                      name: '${day}_closed',
                      title: const Text("Closed"),
                      initialValue: isClosed,
                      onChanged: (value) {
                        field.didChange(value);
                        setState(() {}); // Rebuild to update time picker state
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
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
                      label: "Open Time",
                      enabled: !isClosed,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTimePicker(
                      name: '${day}_close_time',
                      label: "Close Time",
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
          label: "Site Name",
          validator: FormBuilderValidators.required(),
        ),
        const SizedBox(height: 16),
        const AppCheckbox(name: 'site_public', title: AppText("Make site public")),
        const SizedBox(height: 16),
        AppTextField(
          name: 'reply_email',
          label: "Reply Email",
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const SizedBox(height: 16),
        const AppTextField(name: 'google_analytics_id', label: "Google Analytics ID"),
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
        const AppText('Top Image (Image Picker to be implemented)'),
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
        const AppRichTextEditor(name: 'privacy_policy', label: "Privacy Policy"),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IntrinsicWidth(
          child: AppButton(
            text: "Cancel",
            color: AppButtonColor.secondary,
            onPressed: () => context.router.pop(),
          ),
        ),
        const SizedBox(width: 16),
        IntrinsicWidth(
          child: AppButton(
            text: "Save Changes",
            color: AppButtonColor.primary,
            onPressed: _handleSubmit,
          ),
        ),
      ],
    );
  }
}
