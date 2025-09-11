import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final int id;
  final String title;
  final String content;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final Meta meta;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    this.startDate,
    this.endDate,
    required this.isActive,
    required this.meta,
  });

  @override
  List<Object?> get props {
    return [id, title, content, startDate, endDate, isActive, meta];
  }
}

class Meta extends Equatable {
  final String locale;
  final bool fallbackUsed;

  Meta({required this.locale, required this.fallbackUsed});

  @override
  List<Object> get props => [locale, fallbackUsed];
}
