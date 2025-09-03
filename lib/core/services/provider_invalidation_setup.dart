import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/services/provider_invalidation_service.dart';
import 'package:tires/di/service_providers.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_provider.dart';
import 'package:tires/features/home/presentation/providers/menu_provider.dart';
import 'package:tires/features/reservation/presentation/providers/reservation_providers.dart';
import 'package:tires/features/reservation/presentation/screens/create_reservation_screen.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';

/// Initializes the provider invalidation service with the necessary callback
void setupProviderInvalidation(WidgetRef ref) {
  final providerInvalidationService = ref.read(
    providerInvalidationServiceProvider,
  );

  providerInvalidationService.setInvalidationCallback(() {
    // Invalidate current user providers
    ref.invalidate(currentUserGetNotifierProvider);
    ref.invalidate(currentUserMutationNotifierProvider);
    ref.invalidate(currentUserReservationsNotifierProvider);

    // Invalidate customer management providers
    ref.invalidate(customerNotifierProvider);

    // Invalidate menu providers (as they might have user-specific data)
    ref.invalidate(menuNotifierProvider);

    // Clear any selection providers that might persist user data
    ref.invalidate(selectedDateProvider);
    ref.invalidate(selectedTimeProvider);
    ref.invalidate(selectedMenuProvider);
    ref.invalidate(currentMonthProvider);

    // // Invalidate mock availability state if it contains user data
    // ref.invalidate(mockAvailabilityStateProvider);

    // Additional cleanup for any computed providers
    ref.invalidate(menusProvider);
    ref.invalidate(activeMenusProvider);
    ref.invalidate(menuLoadingProvider);
    ref.invalidate(menuErrorProvider);
  });
}
