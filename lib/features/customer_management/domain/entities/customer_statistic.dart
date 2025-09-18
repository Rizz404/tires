import 'package:equatable/equatable.dart';

class CustomerStatistic extends Equatable {
  final int totalCustomers;
  final int firstTime;
  final int repeat;
  final int dormant;

  const CustomerStatistic({
    required this.totalCustomers,
    required this.firstTime,
    required this.repeat,
    required this.dormant,
  });

  @override
  List<Object> get props => [totalCustomers, firstTime, repeat, dormant];
}
