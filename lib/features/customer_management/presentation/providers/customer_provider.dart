import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/common_providers.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/customer_management/presentation/providers/current_user_dashboard_get_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/current_user_dashboard_get_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>((ref) {
      final getCustomerCursorUsecase = ref.watch(
        getCustomerCursorUsecaseProvider,
      );
      return CustomerNotifier(getCustomerCursorUsecase);
    });

final currentUserDashboardGetNotifierProvider =
    StateNotifierProvider<
      CurrentUserDashboardGetNotifier,
      CurrentUserDashboardGetState
    >((ref) {
      final getCurrentUserDashboardUsecase = ref.watch(
        getCurrentUserDashboardUsecaseProvider,
      );
      return CurrentUserDashboardGetNotifier(getCurrentUserDashboardUsecase);
    });
