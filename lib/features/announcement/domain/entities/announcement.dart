import 'package:equatable/equatable.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';

class Announcement extends Equatable {
  final int id;
  final String title;
  final String content;
  final DateTime? publishedAt;
  final bool isActive;
  final Meta meta;
  final AnnouncementTranslation? translations;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    this.publishedAt,
    required this.isActive,
    required this.meta,
    this.translations,
  });

  @override
  List<Object?> get props {
    return [id, title, content, publishedAt, isActive, meta, translations];
  }
}

class Meta extends Equatable {
  final String locale;
  final bool fallbackUsed;

  Meta({required this.locale, required this.fallbackUsed});

  @override
  List<Object> get props => [locale, fallbackUsed];
}
