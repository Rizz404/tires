import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_state.dart';

class InquiryMutationNotifier extends Notifier<InquiryMutationState> {
  late final CreateInquiryUsecase _createInquiryUsecase;

  @override
  InquiryMutationState build() {
    _createInquiryUsecase = ref.watch(createInquiryUsecaseProvider);
    return const InquiryMutationState();
  }

  Future<void> createInquiry({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  }) async {
    AppLogger.uiInfo('Creating inquiry');
    state = state.copyWith(status: InquiryMutationStatus.loading);

    final params = CreateInquiryParams(
      name: name,
      email: email,
      phone: phone,
      subject: subject,
      message: message,
    );

    final response = await _createInquiryUsecase(params);

    response.fold(
      (failure) {
        AppLogger.uiError('Failed to create inquiry', failure);
        state = state.copyWith(
          status: InquiryMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
        AppLogger.uiInfo('Inquiry created successfully');
        state = state
            .copyWith(
              status: InquiryMutationStatus.success,
              createdInquiryResponse: success.data,
              successMessage: success.message ?? 'Inquiry sent successfully',
            )
            .copyWithClearError();
      },
    );
  }

  void clearState() {
    AppLogger.uiInfo('Clearing inquiry mutation state');
    state = const InquiryMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      AppLogger.uiInfo('Clearing inquiry error state');
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      AppLogger.uiInfo('Clearing inquiry success state');
      state = state.copyWithClearSuccess();
    }
  }
}
