import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/di/usecase_providers.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_notifier.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_state.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      final getDashboardUsecase = ref.watch(getDashboardUsecaseProvider);
      return DashboardNotifier(getDashboardUsecase);
    });
