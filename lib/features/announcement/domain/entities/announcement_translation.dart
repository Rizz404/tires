import 'package:equatable/equatable.dart';

class AnnouncementTranslation extends Equatable {
  final AnnouncementContent en;
  final AnnouncementContent ja;

  const AnnouncementTranslation({required this.en, required this.ja});

  @override
  List<Object> get props => [en, ja];
}

class AnnouncementContent extends Equatable {
  final String title;
  final String content;

  const AnnouncementContent({required this.title, required this.content});

  @override
  List<Object> get props => [title, content];
}
