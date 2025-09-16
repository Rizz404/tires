// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MenuStatistic extends Equatable {
  final Statistics statistics;

  MenuStatistic({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class Statistics extends Equatable {
  final int totalMenus;
  final int activeMenus;
  final int inactiveMenus;
  final int averagePrice;

  Statistics({
    required this.totalMenus,
    required this.activeMenus,
    required this.inactiveMenus,
    required this.averagePrice,
  });

  @override
  List<Object> get props => [
    totalMenus,
    activeMenus,
    inactiveMenus,
    averagePrice,
  ];
}
