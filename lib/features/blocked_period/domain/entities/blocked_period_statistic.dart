import 'package:equatable/equatable.dart';

class BlockedPeriodStatistic extends Equatable {
  final num total;
  final num active;
  final num upcoming;
  final num expired;
  final num allMenus;
  final num specificMenus;
  final num totalDurationHours;

  const BlockedPeriodStatistic({
    required this.total,
    required this.active,
    required this.upcoming,
    required this.expired,
    required this.allMenus,
    required this.specificMenus,
    required this.totalDurationHours,
  });

  @override
  List<Object> get props => [
    total,
    active,
    upcoming,
    expired,
    allMenus,
    specificMenus,
    totalDurationHours,
  ];
}
