import 'package:equatable/equatable.dart';

class CustomerStatistic extends Equatable {
  final Statistic statistics;
  final int totalCustomers;

  const CustomerStatistic({
    required this.statistics,
    required this.totalCustomers,
  });

  @override
  List<Object> get props => [statistics, totalCustomers];
}

class Statistic extends Equatable {
  final int firstTime;
  final int repeat;
  final int dormant;

  Statistic({
    required this.firstTime,
    required this.repeat,
    required this.dormant,
  });

  @override
  List<Object> get props => [firstTime, repeat, dormant];
}
