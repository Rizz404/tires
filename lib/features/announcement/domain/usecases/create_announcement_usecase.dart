import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

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
  final AnnouncementTranslation? translation;

  const CreateAnnouncementParams({
    required this.isActive,
    required this.publishedAt,
    this.translation,
  });

  CreateAnnouncementParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    AnnouncementTranslation? translation,
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
      'publishedAt': publishedAt.toIso8601String(),
      'translation': {
        'en': {
          'title': translation?.en.title,
          'content': translation?.en.content,
        },
        'ja': {
          'title': translation?.ja.title,
          'content': translation?.ja.content,
        },
      },
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isActive, publishedAt, translation];
}
