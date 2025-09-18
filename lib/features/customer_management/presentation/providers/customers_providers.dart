import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_state.dart';
import 'package:tires/features/customer_management/presentation/providers/current_user_dashboard_get_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/current_user_dashboard_get_state.dart';

final customersNotifierProvider =
    NotifierProvider<CustomersNotifier, CustomersState>(CustomersNotifier.new);

final customerStatisticsNotifierProvider =
    NotifierProvider<CustomerStatisticsNotifier, CustomerStatisticsState>(
      CustomerStatisticsNotifier.new,
    );

final customerNotifierProvider =
    NotifierProvider<CustomerNotifier, CustomerState>(CustomerNotifier.new);

final currentUserDashboardGetNotifierProvider =
    NotifierProvider<
      CurrentUserDashboardGetNotifier,
      CurrentUserDashboardGetState
    >(CurrentUserDashboardGetNotifier.new);
