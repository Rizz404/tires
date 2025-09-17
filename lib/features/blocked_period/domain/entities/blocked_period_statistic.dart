// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:tires/core/services/app_logger.dart';

class BlockedPeriodStatistic extends Equatable {
  final Statistics statistics;

  BlockedPeriodStatistic({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class Statistics extends Equatable {
  final int total;
  final int active;
  final int upcoming;
  final int expired;
  final int allMenus;
  final int specificMenus;
  final int totalDurationHours;

  Statistics({
    required this.total,
    required this.active,
    required this.upcoming,
    required this.expired,
    required this.allMenus,
    required this.specificMenus,
    required this.totalDurationHours,
  });

  @override
  List<Object> get props {
    return [
      total,
      active,
      upcoming,
      expired,
      allMenus,
      specificMenus,
      totalDurationHours,
    ];
  }
}
