import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_providers.dart';
import 'package:tires/features/business_information/presentation/providers/public_business_information_state.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class TermsOfServiceScreen extends ConsumerWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicBusinessInfoState = ref.watch(
      publicBusinessInformationGetNotifierProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.termsOfServiceScreenTitle)),
      endDrawer: const UserEndDrawer(),
      body: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context.l10n.termsOfServiceScreenTitle),
              const SizedBox(height: 16),
              _buildContent(publicBusinessInfoState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppText(
        title,
        style: AppTextStyle.headlineSmall,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContent(PublicBusinessInformationState state) {
    if (state.status == PublicBusinessInformationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == PublicBusinessInformationStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            AppText(
              state.errorMessage ?? 'Failed to load terms of service',
              style: AppTextStyle.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.status == PublicBusinessInformationStatus.success &&
        state.businessInformation != null) {
      final termsOfService = state.businessInformation!.termsOfUse;

      if (termsOfService.isEmpty) {
        return const Center(
          child: AppText(
            'Terms of service content is not available.',
            style: AppTextStyle.bodyLarge,
            textAlign: TextAlign.center,
          ),
        );
      }

      return Html(
        data: termsOfService,
        style: {
          "body": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
          "p": Style(
            margin: Margins.only(bottom: 16),
            lineHeight: const LineHeight(1.6),
          ),
          "h1, h2, h3, h4, h5, h6": Style(
            margin: Margins.only(top: 24, bottom: 16),
            fontWeight: FontWeight.bold,
          ),
          "ul, ol": Style(
            margin: Margins.only(bottom: 16),
            padding: HtmlPaddings.only(left: 20),
          ),
          "li": Style(
            margin: Margins.only(bottom: 8),
            lineHeight: const LineHeight(1.6),
          ),
        },
      );
    }

    return const Center(
      child: AppText(
        'No terms of service content available.',
        style: AppTextStyle.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
