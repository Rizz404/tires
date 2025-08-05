import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final int id;
  final bool isActive;
  final DateTime? publishedAt;
  final List<AnnouncementTranslation> translations;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Announcement({
    required this.id,
    required this.isActive,
    this.publishedAt,
    required this.translations,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    isActive,
    publishedAt,
    translations,
    createdAt,
    updatedAt,
  ];
}

class AnnouncementTranslation extends Equatable {
  final int id;
  final String locale;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AnnouncementTranslation({
    required this.id,
    required this.locale,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, locale, title, content, createdAt, updatedAt];
}
