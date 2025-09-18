import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/business_information/domain/entities/business_information.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_providers.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_state.dart';
import 'package:tires/shared/presentation/widgets/admin_app_bar.dart';
import 'package:tires/shared/presentation/widgets/admin_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class AdminListBusinessInformationScreen extends ConsumerStatefulWidget {
  const AdminListBusinessInformationScreen({super.key});

  @override
  ConsumerState<AdminListBusinessInformationScreen> createState() =>
      _AdminListBusinessInformationScreenState();
}

class _AdminListBusinessInformationScreenState
    extends ConsumerState<AdminListBusinessInformationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(businessInformationGetNotifierProvider.notifier)
          .getBusinessInformation();
    });
  }

  Future<void> _refreshBusinessInformation() async {
    await ref.read(businessInformationGetNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(businessInformationGetNotifierProvider);

    return Scaffold(
      appBar: const AdminAppBar(),
      endDrawer: const AdminEndDrawer(),
      body: ScreenWrapper(
        child: RefreshIndicator(
          onRefresh: _refreshBusinessInformation,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              if (state.status == BusinessInformationStatus.loading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.businessInformation != null) ...[
                SliverToBoxAdapter(
                  child: _buildHeader(context, state.businessInformation!),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: _buildBasicInformation(context, state),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildBusinessHours(context, state)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: _buildSiteSettings(context, state)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: _buildDescriptionAndImage(context, state),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: _buildPoliciesAndTerms(context, state),
                ),
              ] else
                SliverToBoxAdapter(child: _buildNotFound(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    BusinessInformation businessInformation,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  context.l10n.adminListBusinessInformationScreenTitle,
                  style: AppTextStyle.headlineMedium,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                AppText(
                  context.l10n.adminListBusinessInformationScreenDescription,
                  style: AppTextStyle.bodyLarge,
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AppButton(
            color: AppButtonColor.primary,
            isFullWidth: false,
            text: context.l10n.adminListBusinessInformationScreenEditButton,
            leadingIcon: const Icon(Icons.edit),
            onPressed: () {
              final state = ref.read(businessInformationGetNotifierProvider);
              if (state.businessInformation != null) {
                context.router.push(
                  AdminEditBusinessInformationRoute(
                    businessInformation: state.businessInformation!,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformation(
    BuildContext context,
    BusinessInformationState state,
  ) {
    final info = state.businessInformation!;

    return _buildSection(
      context,
      title: context.l10n.adminListBusinessInformationScreenBasicInfoTitle,
      icon: Icons.storefront,
      iconColor: Colors.blue.shade800,
      children: [
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenBasicInfoShopName,
          info.shopName,
        ),
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenBasicInfoPhoneNumber,
          info.phoneNumber,
        ),
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenBasicInfoAddress,
          info.address,
        ),
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenBasicInfoWebsiteUrl,
          info.websiteUrl ??
              context.l10n.adminListBusinessInformationScreenNotSet,
          isLink: info.websiteUrl != null,
        ),
      ],
    );
  }

  Widget _buildBusinessHours(
    BuildContext context,
    BusinessInformationState state,
  ) {
    final info = state.businessInformation!;
    final businessHours = info.businessHours;

    return _buildSection(
      context,
      title: context.l10n.adminListBusinessInformationScreenBusinessHoursTitle,
      icon: Icons.access_time_filled,
      iconColor: Colors.green.shade800,
      children: [
        if (businessHours.isEmpty)
          AppText(
            context.l10n.adminListBusinessInformationScreenBusinessHoursNotSet,
            style: AppTextStyle.bodyMedium,
            color: context.colorScheme.onSurface.withOpacity(0.6),
          )
        else
          ..._buildBusinessHoursList(context, businessHours),
      ],
    );
  }

  List<Widget> _buildBusinessHoursList(
    BuildContext context,
    Map<String, dynamic> businessHours,
  ) {
    final days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    final dayLabels = [
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysMonday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysTuesday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysWednesday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysThursday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysFriday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysSaturday,
      context.l10n.adminListBusinessInformationScreenBusinessHoursDaysSunday,
    ];

    return days.asMap().entries.map((entry) {
      final index = entry.key;
      final day = entry.value;
      final dayData = businessHours[day] as Map<String, dynamic>?;

      String timeText;
      Color? timeColor;

      if (dayData != null && dayData['closed'] != true) {
        final openTime = dayData['open'] as String?;
        final closeTime = dayData['close'] as String?;
        if (openTime != null && closeTime != null) {
          timeText = '$openTime - $closeTime';
        } else {
          timeText = context
              .l10n
              .adminListBusinessInformationScreenBusinessHoursClosed;
          timeColor = Colors.red;
        }
      } else {
        timeText =
            context.l10n.adminListBusinessInformationScreenBusinessHoursClosed;
        timeColor = Colors.red;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(dayLabels[index], style: AppTextStyle.bodyLarge),
            AppText(
              timeText,
              style: AppTextStyle.bodyLarge,
              color: timeColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSiteSettings(
    BuildContext context,
    BusinessInformationState state,
  ) {
    final info = state.businessInformation!;

    return _buildSection(
      context,
      title: context.l10n.adminListBusinessInformationScreenSiteSettingsTitle,
      icon: Icons.language,
      iconColor: Colors.purple.shade800,
      children: [
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenSiteSettingsSiteName,
          info.siteName,
        ),
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenSiteSettingsSiteStatus,
          info.sitePublic
              ? context
                    .l10n
                    .adminListBusinessInformationScreenSiteSettingsPublic
              : context
                    .l10n
                    .adminListBusinessInformationScreenSiteSettingsPrivate,
          statusWidget: Chip(
            label: AppText(
              info.sitePublic
                  ? context
                        .l10n
                        .adminListBusinessInformationScreenSiteSettingsPublic
                  : context
                        .l10n
                        .adminListBusinessInformationScreenSiteSettingsPrivate,
              style: AppTextStyle.labelMedium,
              color: info.sitePublic
                  ? Colors.green.shade800
                  : Colors.grey.shade700,
            ),
            backgroundColor: info.sitePublic
                ? Colors.green.shade100
                : Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none,
            ),
          ),
        ),
        _buildInfoColumn(
          context.l10n.adminListBusinessInformationScreenSiteSettingsReplyEmail,
          info.replyEmail ??
              context.l10n.adminListBusinessInformationScreenNotSet,
        ),
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenSiteSettingsGoogleAnalyticsId,
          info.googleAnalyticsId ??
              context.l10n.adminListBusinessInformationScreenNotSet,
        ),
      ],
    );
  }

  Widget _buildDescriptionAndImage(
    BuildContext context,
    BusinessInformationState state,
  ) {
    final info = state.businessInformation!;

    return _buildSection(
      context,
      title:
          context.l10n.adminListBusinessInformationScreenDescriptionImageTitle,
      icon: Icons.image,
      iconColor: Colors.orange.shade800,
      children: [
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenDescriptionImageShopDescriptionLabel,
          info.shopDescription.isNotEmpty
              ? info.shopDescription
              : context
                    .l10n
                    .adminListBusinessInformationScreenDescriptionImageShopDescriptionNotSet,
        ),
        const SizedBox(height: 16),
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenDescriptionImageTopImageLabel,
          info.topImageUrl == null
              ? context
                    .l10n
                    .adminListBusinessInformationScreenDescriptionImageTopImageNotSet
              : '',
          customContent: info.topImageUrl != null
              ? Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      info.topImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: context.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.broken_image,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 16),
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenDescriptionImageAccessInformationLabel,
          info.accessInformation.isNotEmpty
              ? info.accessInformation
              : context
                    .l10n
                    .adminListBusinessInformationScreenDescriptionImageAccessInformationNotSet,
        ),
      ],
    );
  }

  Widget _buildPoliciesAndTerms(
    BuildContext context,
    BusinessInformationState state,
  ) {
    final info = state.businessInformation!;

    return _buildSection(
      context,
      title: context.l10n.adminListBusinessInformationScreenPoliciesTermsTitle,
      icon: Icons.policy,
      iconColor: Colors.blueGrey.shade800,
      children: [
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenPoliciesTermsTermsOfUseLabel,
          '',
          customContent: Html(
            data: info.termsOfUse.isNotEmpty
                ? info.termsOfUse
                : '<p>${context.l10n.adminListBusinessInformationScreenPoliciesTermsTermsOfUseNotSet}</p>',
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoColumn(
          context
              .l10n
              .adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyLabel,
          '',
          customContent: Html(
            data: info.privacyPolicy.isNotEmpty
                ? info.privacyPolicy
                : '<p>${context.l10n.adminListBusinessInformationScreenPoliciesTermsPrivacyPolicyNotSet}</p>',
          ),
        ),
      ],
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.business, size: 80, color: context.colorScheme.outline),
            const SizedBox(height: 16),
            AppText(
              context.l10n.adminListBusinessInformationScreenNotFoundTitle,
              style: AppTextStyle.headlineSmall,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText(
              context
                  .l10n
                  .adminListBusinessInformationScreenNotFoundDescription,
              style: AppTextStyle.bodyLarge,
              color: context.colorScheme.onSurface.withOpacity(0.7),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              color: AppButtonColor.primary,
              isFullWidth: false,
              text: context
                  .l10n
                  .adminListBusinessInformationScreenNotFoundCreateButton,
              leadingIcon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
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
                Icon(icon, size: 22, color: iconColor),
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

  Widget _buildInfoColumn(
    String label,
    String value, {
    bool isLink = false,
    Widget? statusWidget,
    Widget? customContent,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label,
            style: AppTextStyle.bodyMedium,
            color: context.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 4),
          if (customContent != null)
            customContent
          else if (statusWidget != null)
            Align(alignment: Alignment.centerLeft, child: statusWidget)
          else
            AppText(
              value,
              style: AppTextStyle.bodyLarge,
              color: value.contains('not set') || value.contains('Not set')
                  ? Colors.grey
                  : (isLink ? context.colorScheme.primary : null),
            ),
        ],
      ),
    );
  }
}
