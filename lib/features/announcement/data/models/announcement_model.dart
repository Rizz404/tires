import 'dart:convert';
import 'package:tires/features/user/domain/entities/announcement.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class AnnouncementModel extends Announcement {
  AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    super.startDate,
    super.endDate,
    required super.isActive,
    required MetaModel super.meta,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('AnnouncementModel', map);
    try {
      final startDateString = DebugHelper.safeCast<String>(
        map['start_date'],
        'start_date',
      );
      final endDateString = DebugHelper.safeCast<String>(
        map['end_date'],
        'end_date',
      );

      return AnnouncementModel(
        id: DebugHelper.safeCast<int>(map['id'], 'id', defaultValue: 0) ?? 0,
        title:
            DebugHelper.safeCast<String>(
              map['title'],
              'title',
              defaultValue: '',
            ) ??
            '',
        content:
            DebugHelper.safeCast<String>(
              map['content'],
              'content',
              defaultValue: '',
            ) ??
            '',
        startDate: startDateString != null
            ? DateTime.tryParse(startDateString)
            : null,
        endDate: endDateString != null
            ? DateTime.tryParse(endDateString)
            : null,
        isActive:
            DebugHelper.safeCast<bool>(
              map['is_active'],
              'is_active',
              defaultValue: false,
            ) ??
            false,
        meta: map['meta'] != null && map['meta'] is Map<String, dynamic>
            ? MetaModel.fromMap(map['meta'])
            : MetaModel(locale: 'en', fallbackUsed: true),
      );
    } catch (e, stackTrace) {
      print('❌ Error in AnnouncementModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive,
      'meta': (meta as MetaModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class MetaModel extends Meta {
  MetaModel({required super.locale, required super.fallbackUsed});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('MetaModel', map);
    return MetaModel(
      locale:
          DebugHelper.safeCast<String>(
            map['locale'],
            'locale',
            defaultValue: 'en',
          ) ??
          'en',
      fallbackUsed:
          DebugHelper.safeCast<bool>(
            map['fallback_used'],
            'fallback_used',
            defaultValue: false,
          ) ??
          false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'locale': locale, 'fallback_used': fallbackUsed};
  }
}
