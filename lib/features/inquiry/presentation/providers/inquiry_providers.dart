import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_notifier.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';

final inquiryMutationNotifierProvider =
    StateNotifierProvider<InquiryMutationNotifier, InquiryMutationState>((ref) {
      final createInquiryUsecase = ref.watch(createInquiryUsecaseProvider);
      return InquiryMutationNotifier(createInquiryUsecase);
    });

// Re-export user providers for convenience in inquiry screens
final inquiryUserGetNotifierProvider = currentUserGetNotifierProvider;
