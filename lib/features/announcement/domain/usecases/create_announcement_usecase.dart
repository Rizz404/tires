import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

class CreateAnnouncementUsecase
    implements
        Usecase<ItemSuccessResponse<Announcement>, CreateAnnouncementParams> {
  final AnnouncementRepository repository;

  CreateAnnouncementUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> call(
    CreateAnnouncementParams params,
  ) {
    return repository.createAnnouncement(params);
  }
}

class CreateAnnouncementParams extends Equatable {
  final bool isActive;
  final DateTime publishedAt;
  final Translation? translation;

  const CreateAnnouncementParams({
    required this.isActive,
    required this.publishedAt,
    this.translation,
  });

  CreateAnnouncementParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    Translation? translation,
  }) {
    return CreateAnnouncementParams(
      isActive: isActive ?? this.isActive,
      publishedAt: publishedAt ?? this.publishedAt,
      translation: translation ?? this.translation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'translation': translation?.toMap(),
    };
  }

  factory CreateAnnouncementParams.fromMap(Map<String, dynamic> map) {
    return CreateAnnouncementParams(
      isActive: map['isActive'] as bool,
      publishedAt: DateTime.fromMillisecondsSinceEpoch(
        map['publishedAt'] as int,
      ),
      translation: map['translation'] != null
          ? Translation.fromMap(map['translation'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateAnnouncementParams.fromJson(String source) =>
      CreateAnnouncementParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isActive, publishedAt, translation];
}

class Translation extends Equatable {
  final AnnouncementEn en;
  final AnnouncementJa ja;

  const Translation({required this.en, required this.ja});

  Translation copyWith({AnnouncementEn? en, AnnouncementJa? ja}) {
    return Translation(en: en ?? this.en, ja: ja ?? this.ja);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'en': en.toMap(), 'ja': ja.toMap()};
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      en: AnnouncementEn.fromMap(map['en'] as Map<String, dynamic>),
      ja: AnnouncementJa.fromMap(map['ja'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [en, ja];
}

class AnnouncementEn extends Equatable {
  final String title;
  final String content;

  const AnnouncementEn({required this.title, required this.content});

  AnnouncementEn copyWith({String? title, String? content}) {
    return AnnouncementEn(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'content': content};
  }

  factory AnnouncementEn.fromMap(Map<String, dynamic> map) {
    return AnnouncementEn(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementEn.fromJson(String source) =>
      AnnouncementEn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, content];
}

class AnnouncementJa extends Equatable {
  final String title;
  final String content;

  const AnnouncementJa({required this.title, required this.content});

  AnnouncementJa copyWith({String? title, String? content}) {
    return AnnouncementJa(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'content': content};
  }

  factory AnnouncementJa.fromMap(Map<String, dynamic> map) {
    return AnnouncementJa(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementJa.fromJson(String source) =>
      AnnouncementJa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, content];
}
