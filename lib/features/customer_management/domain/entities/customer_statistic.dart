import 'package:equatable/equatable.dart';

class CustomerStatistic extends Equatable {
  final int totalCustomers;
  final int firstTimeCustomers;
  final int repeatCustomers;
  final int dormantCustomers;

  const CustomerStatistic({
    required this.totalCustomers,
    required this.firstTimeCustomers,
    required this.repeatCustomers,
    required this.dormantCustomers,
  });

  @override
  List<Object> get props => [
    totalCustomers,
    firstTimeCustomers,
    repeatCustomers,
    dormantCustomers,
  ];
}
