import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_notifier.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';

final inquiryMutationNotifierProvider =
    NotifierProvider<InquiryMutationNotifier, InquiryMutationState>(
      InquiryMutationNotifier.new,
    );

// Re-export user providers for convenience in inquiry screens
final inquiryUserGetNotifierProvider = currentUserGetNotifierProvider;
