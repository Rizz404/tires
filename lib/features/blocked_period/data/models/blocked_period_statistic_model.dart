import 'dart:convert';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';

class BlockedPeriodStatisticModel extends BlockedPeriodStatistic {
  const BlockedPeriodStatisticModel({
    required super.total,
    required super.active,
    required super.upcoming,
    required super.expired,
    required super.allMenus,
    required super.specificMenus,
    required super.totalDurationHours,
  });

  factory BlockedPeriodStatisticModel.fromMap(Map<String, dynamic> map) {
    try {
      return BlockedPeriodStatisticModel(
        total: (map['total'] as num?) ?? 0,
        active: (map['active'] as num?) ?? 0,
        upcoming: (map['upcoming'] as num?) ?? 0,
        expired: (map['expired'] as num?) ?? 0,
        allMenus: (map['all_menus'] as num?) ?? 0,
        specificMenus: (map['specific_menus'] as num?) ?? 0,
        totalDurationHours: (map['total_duration_hours'] as num?) ?? 0,
      );
    } catch (e, stackTrace) {
      print('❌ Error in BlockedPeriodStatisticModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory BlockedPeriodStatisticModel.fromJson(String source) =>
      BlockedPeriodStatisticModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'active': active,
      'upcoming': upcoming,
      'expired': expired,
      'all_menus': allMenus,
      'specific_menus': specificMenus,
      'total_duration_hours': totalDurationHours,
    };
  }

  String toJson() => json.encode(toMap());
}
