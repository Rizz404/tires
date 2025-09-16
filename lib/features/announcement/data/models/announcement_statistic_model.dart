import 'dart:convert';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class AnnouncementStatisticModel extends AnnouncementStatistic {
  AnnouncementStatisticModel({
    required super.totalAnnouncements,
    required super.active,
    required super.inactive,
    required super.today,
  });

  factory AnnouncementStatisticModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('AnnouncementStatisticModel', map);
    try {
      return AnnouncementStatisticModel(
        totalAnnouncements:
            DebugHelper.safeCast<int>(
              map['total_announcements'],
              'total_announcements',
              defaultValue: 0,
            ) ??
            0,
        active:
            DebugHelper.safeCast<int>(
              map['active'],
              'active',
              defaultValue: 0,
            ) ??
            0,
        inactive:
            DebugHelper.safeCast<int>(
              map['inactive'],
              'inactive',
              defaultValue: 0,
            ) ??
            0,
        today:
            DebugHelper.safeCast<int>(map['today'], 'today', defaultValue: 0) ??
            0,
      );
    } catch (e) {
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
