import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

class UpdateAnnouncementUsecase
    implements
        Usecase<ItemSuccessResponse<Announcement>, UpdateAnnouncementParams> {
  final AnnouncementRepository repository;

  UpdateAnnouncementUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Announcement>>> call(
    UpdateAnnouncementParams params,
  ) {
    return repository.updateAnnouncement(params);
  }
}

class UpdateAnnouncementParams extends Equatable {
  final String id;
  final bool? isActive;
  final DateTime? publishedAt;
  final Translation? translation;

  const UpdateAnnouncementParams({
    required this.id,
    this.isActive,
    this.publishedAt,
    this.translation,
  });

  UpdateAnnouncementParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    Translation? translation,
  }) {
    return UpdateAnnouncementParams(
      id: id,
      isActive: isActive ?? this.isActive,
      publishedAt: publishedAt ?? this.publishedAt,
      translation: translation ?? this.translation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isActive': isActive,
      'publishedAt': publishedAt?.millisecondsSinceEpoch,
      'translation': translation?.toMap(),
    };
  }

  factory UpdateAnnouncementParams.fromMap(Map<String, dynamic> map) {
    return UpdateAnnouncementParams(
      id: map['id'] as String,
      isActive: map['isActive'] as bool?,
      publishedAt: map['publishedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['publishedAt'] as int)
          : null,
      translation: map['translation'] != null
          ? Translation.fromMap(map['translation'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateAnnouncementParams.fromJson(String source) =>
      UpdateAnnouncementParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, isActive, publishedAt, translation];
}

class Translation extends Equatable {
  final AnnouncementMainContent? en;
  final AnnouncementMainContent? ja;

  const Translation({this.en, this.ja});

  Translation copyWith({
    AnnouncementMainContent? en,
    AnnouncementMainContent? ja,
  }) {
    return Translation(en: en ?? this.en, ja: ja ?? this.ja);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'en': en?.toMap(), 'ja': ja?.toMap()};
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      en: map['en'] != null
          ? AnnouncementMainContent.fromMap(map['en'] as Map<String, dynamic>)
          : null,
      ja: map['ja'] != null
          ? AnnouncementMainContent.fromMap(map['ja'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [en, ja];
}

class AnnouncementMainContent extends Equatable {
  final String? title;
  final String? content;

  const AnnouncementMainContent({this.title, this.content});

  AnnouncementMainContent copyWith({String? title, String? content}) {
    return AnnouncementMainContent(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'content': content};
  }

  factory AnnouncementMainContent.fromMap(Map<String, dynamic> map) {
    return AnnouncementMainContent(
      title: map['title'] as String?,
      content: map['content'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementMainContent.fromJson(String source) =>
      AnnouncementMainContent.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [title, content];
}
