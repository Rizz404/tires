import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>((ref) {
      final getCustomerCursorUsecase = ref.watch(
        getCustomerCursorUsecaseProvider,
      );
      return CustomerNotifier(getCustomerCursorUsecase);
    });
