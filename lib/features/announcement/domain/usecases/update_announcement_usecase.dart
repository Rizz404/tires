import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

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
  final int id;
  final bool? isActive;
  final DateTime? publishedAt;
  final AnnouncementTranslation? translation;

  const UpdateAnnouncementParams({
    required this.id,
    this.isActive,
    this.publishedAt,
    this.translation,
  });

  UpdateAnnouncementParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    AnnouncementTranslation? translation,
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
      'publishedAt': publishedAt?.toIso8601String(),
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
  List<Object?> get props => [id, isActive, publishedAt, translation];
}
