import 'dart:convert';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';

class AnnouncementStatisticModel extends AnnouncementStatistic {
  AnnouncementStatisticModel({
    required super.totalAnnouncements,
    required super.active,
    required super.inactive,
    required super.today,
  });

  factory AnnouncementStatisticModel.fromMap(Map<String, dynamic> map) {
    try {
      print('🔍 AnnouncementStatisticModel.fromMap called with: $map');
      return AnnouncementStatisticModel(
        totalAnnouncements: (map['total_announcements'] as int?) ?? 0,
        active: (map['active'] as int?) ?? 0,
        inactive: (map['inactive'] as int?) ?? 0,
        today: (map['today'] as int?) ?? 0,
      );
    } catch (e, stackTrace) {
      print('❌ Error in AnnouncementStatisticModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory AnnouncementStatisticModel.fromJson(String source) =>
      AnnouncementStatisticModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'total_announcements': totalAnnouncements,
      'active': active,
      'inactive': inactive,
      'today': today,
    };
  }

  String toJson() => json.encode(toMap());
}
