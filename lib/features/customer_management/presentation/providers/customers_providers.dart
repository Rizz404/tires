import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customers_state.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_notifier.dart';
import 'package:tires/features/customer_management/presentation/providers/customer_statistics_state.dart';

final customersNotifierProvider = NotifierProvider<CustomersNotifier, CustomersState>(
  CustomersNotifier.new,
);

final customerStatisticsNotifierProvider = NotifierProvider<CustomerStatisticsNotifier, CustomerStatisticsState>(
  CustomerStatisticsNotifier.new,
);
