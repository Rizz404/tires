import 'dart:convert';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_translation.dart';

class BlockedPeriodModel extends BlockedPeriod {
  const BlockedPeriodModel({
    required super.id,
    super.menuId,
    required super.startDatetime,
    required super.endDatetime,
    required super.reason,
    required super.allMenuForBlockedPeriods,
    required super.createdAt,
    required super.updatedAt,
    super.menu,
    required super.duration,
    required super.status,
    super.translations,
    required super.meta,
  });

  factory BlockedPeriodModel.fromMap(Map<String, dynamic> map) {
    try {
      return BlockedPeriodModel(
        id: (map['id'] as int?) ?? 0,
        menuId: map['menu_id'] as num?,
        startDatetime: DateTime.parse(map['start_datetime'] as String),
        endDatetime: DateTime.parse(map['end_datetime'] as String),
        reason: (map['reason'] as String?) ?? '',
        allMenuForBlockedPeriods: (map['all_menus'] as bool?) ?? false,
        createdAt: DateTime.parse(map['created_at'] as String),
        updatedAt: DateTime.parse(map['updated_at'] as String),
        menu: map['menu'] != null && map['menu'] is Map<String, dynamic>
            ? MenuModelForBlockedPeriod.fromMap(map['menu'])
            : null,
        duration: DurationModel.fromMap(
          map['duration'] as Map<String, dynamic>,
        ),
        status: (map['status'] as String?) ?? '',
        translations:
            map['translations'] != null &&
                map['translations'] is Map<String, dynamic>
            ? BlockedPeriodTranslationModel.fromMap(map['translations'])
            : null,
        meta: map['meta'] != null && map['meta'] is Map<String, dynamic>
            ? MetaModel.fromMap(map['meta'])
            : const MetaModel(locale: 'en', fallbackUsed: true),
      );
    } catch (e, stackTrace) {
      print('❌ Error in BlockedPeriodModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  factory BlockedPeriodModel.fromJson(String source) =>
      BlockedPeriodModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'menu_id': menuId,
      'start_datetime': startDatetime.toIso8601String(),
      'end_datetime': endDatetime.toIso8601String(),
      'reason': reason,
      'all_menus': allMenuForBlockedPeriods,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'menu': menu != null ? (menu as MenuModelForBlockedPeriod).toMap() : null,
      'duration': (duration as DurationModel).toMap(),
      'status': status,
      'translations': translations != null
          ? (translations as BlockedPeriodTranslationModel).toMap()
          : null,
      'meta': (meta as MetaModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class MenuModelForBlockedPeriod extends MenuForBlockedPeriod {
  const MenuModelForBlockedPeriod({
    required super.id,
    required super.name,
    required super.color,
  });

  factory MenuModelForBlockedPeriod.fromMap(Map<String, dynamic> map) {
    return MenuModelForBlockedPeriod(
      id: (map['id'] as int?) ?? 0,
      name: (map['name'] as String?) ?? '',
      color: (map['color'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color};
  }
}

class DurationModel extends Duration {
  const DurationModel({
    required super.hours,
    required super.minutes,
    required super.text,
    required super.isShort,
  });

  factory DurationModel.fromMap(Map<String, dynamic> map) {
    return DurationModel(
      hours: (map['hours'] as num?) ?? 0,
      minutes: (map['minutes'] as num?) ?? 0,
      text: (map['text'] as String?) ?? '',
      isShort: (map['is_short'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hours': hours,
      'minutes': minutes,
      'text': text,
      'is_short': isShort,
    };
  }
}

class MetaModel extends Meta {
  const MetaModel({required super.locale, required super.fallbackUsed});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      locale: (map['locale'] as String?) ?? 'en',
      fallbackUsed: (map['fallback_used'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {'locale': locale, 'fallback_used': fallbackUsed};
  }
}

class BlockedPeriodTranslationModel extends BlockedPeriodTranslation {
  const BlockedPeriodTranslationModel({required super.en, required super.ja});

  factory BlockedPeriodTranslationModel.fromMap(Map<String, dynamic> map) {
    return BlockedPeriodTranslationModel(
      en: map['en'] != null && map['en'] is Map<String, dynamic>
          ? BlockedPeriodContentModel.fromMap(map['en'])
          : const BlockedPeriodContentModel(reason: ''),
      ja: map['ja'] != null && map['ja'] is Map<String, dynamic>
          ? BlockedPeriodContentModel.fromMap(map['ja'])
          : const BlockedPeriodContentModel(reason: ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': (en as BlockedPeriodContentModel).toMap(),
      'ja': (ja as BlockedPeriodContentModel).toMap(),
    };
  }
}

class BlockedPeriodContentModel extends BlockedPeriodContent {
  const BlockedPeriodContentModel({required super.reason});

  factory BlockedPeriodContentModel.fromMap(Map<String, dynamic> map) {
    return BlockedPeriodContentModel(reason: (map['reason'] as String?) ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'reason': reason};
  }
}
