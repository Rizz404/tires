// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MenuStatisticModel extends Equatable {
  final StatisticsModel statistics;

  MenuStatisticModel({required this.statistics});

  factory MenuStatisticModel.fromJson(Map<String, dynamic> json) {
    return MenuStatisticModel(
      statistics: StatisticsModel.fromJson(json['statistics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'statistics': statistics.toJson()};
  }

  @override
  List<Object> get props => [statistics];
}

class StatisticsModel extends Equatable {
  final int totalMenus;
  final int activeMenus;
  final int inactiveMenus;
  final num averagePrice;

  StatisticsModel({
    required this.totalMenus,
    required this.activeMenus,
    required this.inactiveMenus,
    required this.averagePrice,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalMenus: json['total_menus'] as int,
      activeMenus: json['active_menus'] as int,
      inactiveMenus: json['inactive_menus'] as int,
      averagePrice: json['average_price'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_menus': totalMenus,
      'active_menus': activeMenus,
      'inactive_menus': inactiveMenus,
      'average_price': averagePrice,
    };
  }

  @override
  List<Object> get props => [
    totalMenus,
    activeMenus,
    inactiveMenus,
    averagePrice,
  ];
}
