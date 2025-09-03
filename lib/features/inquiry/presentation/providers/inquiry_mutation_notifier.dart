import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/inquiry/domain/usecases/create_inquiry_usecase.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_state.dart';

class InquiryMutationNotifier extends StateNotifier<InquiryMutationState> {
  final CreateInquiryUsecase _createInquiryUsecase;

  InquiryMutationNotifier(this._createInquiryUsecase)
    : super(const InquiryMutationState());

  Future<void> createInquiry({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  }) async {
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
        state = state.copyWith(
          status: InquiryMutationStatus.error,
          failure: failure,
        );
      },
      (success) {
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
    state = const InquiryMutationState();
  }

  void clearError() {
    if (state.failure != null) {
      state = state.copyWithClearError();
    }
  }

  void clearSuccess() {
    if (state.successMessage != null) {
      state = state.copyWithClearSuccess();
    }
  }
}
