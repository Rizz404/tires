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
  final int averagePrice;

  StatisticsModel({
    required this.totalMenus,
    required this.activeMenus,
    required this.inactiveMenus,
    required this.averagePrice,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalMenus: json['totalMenus'] as int,
      activeMenus: json['activeMenus'] as int,
      inactiveMenus: json['inactiveMenus'] as int,
      averagePrice: json['averagePrice'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalMenus': totalMenus,
      'activeMenus': activeMenus,
      'inactiveMenus': inactiveMenus,
      'averagePrice': averagePrice,
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
