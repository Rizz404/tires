import 'dart:convert';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';

class AnnouncementModel extends Announcement {
  AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    super.publishedAt,
    required super.isActive,
    required MetaModel super.meta,
    super.translations,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    try {
      final publishedAtString = map['published_at'] as String?;

      return AnnouncementModel(
        id: (map['id'] as int?) ?? 0,
        title: (map['title'] as String?) ?? '',
        content: (map['content'] as String?) ?? '',
        publishedAt: publishedAtString != null
            ? DateTime.tryParse(publishedAtString)
            : null,
        isActive: (map['is_active'] as bool?) ?? false,
        meta: map['meta'] != null && map['meta'] is Map<String, dynamic>
            ? MetaModel.fromMap(map['meta'])
            : MetaModel(locale: 'en', fallbackUsed: true),
        translations:
            map['translations'] != null &&
                map['translations'] is Map<String, dynamic>
            ? AnnouncementTranslationModel.fromMap(map['translations'])
            : null,
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
      'published_at': publishedAt?.toIso8601String(),
      'is_active': isActive,
      'meta': (meta as MetaModel).toMap(),
      'translations': (translations as AnnouncementTranslationModel?)?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class MetaModel extends Meta {
  MetaModel({required super.locale, required super.fallbackUsed});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      locale: (map['locale'] as String?) ?? 'en',
      fallbackUsed: (map['fallback_used'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'locale': locale, 'fallback_used': fallbackUsed};
  }
}

class AnnouncementTranslationModel extends AnnouncementTranslation {
  const AnnouncementTranslationModel({
    required AnnouncementContentModel super.en,
    required AnnouncementContentModel super.ja,
  });

  factory AnnouncementTranslationModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementTranslationModel(
      en: map['en'] != null && map['en'] is Map<String, dynamic>
          ? AnnouncementContentModel.fromMap(map['en'])
          : const AnnouncementContentModel(title: '', content: ''),
      ja: map['ja'] != null && map['ja'] is Map<String, dynamic>
          ? AnnouncementContentModel.fromMap(map['ja'])
          : const AnnouncementContentModel(title: '', content: ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': (en as AnnouncementContentModel).toMap(),
      'ja': (ja as AnnouncementContentModel).toMap(),
    };
  }
}

class AnnouncementContentModel extends AnnouncementContent {
  const AnnouncementContentModel({
    required super.title,
    required super.content,
  });

  factory AnnouncementContentModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementContentModel(
      title: (map['title'] as String?) ?? '',
      content: (map['content'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }
}
