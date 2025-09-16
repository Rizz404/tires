import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_notifier.dart';
import 'package:tires/features/dashboard/presentation/providers/dashboard_state.dart';

final dashboardNotifierProvider =
    NotifierProvider<DashboardNotifier, DashboardState>(DashboardNotifier.new);
