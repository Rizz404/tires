import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_notifier.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_state.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_notifier.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_state.dart';

final businessInformationGetNotifierProvider =
    StateNotifierProvider<
      BusinessInformationNotifier,
      BusinessInformationState
    >((ref) {
      final getBusinessInformationUsecase = ref.watch(
        getBusinessInformationUsecaseProvider,
      );
      return BusinessInformationNotifier(getBusinessInformationUsecase);
    });

final businessInformationMutationNotifierProvider =
    StateNotifierProvider<
      BusinessInformationMutationNotifier,
      BusinessInformationMutationState
    >((ref) {
      final updateBusinessInformationUsecase = ref.watch(
        updateBusinessInformationUsecaseProvider,
      );

      return BusinessInformationMutationNotifier(
        updateBusinessInformationUsecase,
      );
    });
