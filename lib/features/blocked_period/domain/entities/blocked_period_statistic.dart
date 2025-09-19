import 'package:equatable/equatable.dart';

class BlockedPeriodStatistic extends Equatable {
  final int total;
  final int active;
  final int upcoming;
  final int expired;
  final int allMenus;
  final int specificMenus;
  final int totalDurationHours;

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
