import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
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
    AppLogger.businessInfo(
      'Executing update announcement usecase for id: ${params.id}',
    );
    return repository.updateAnnouncement(params);
  }
}

class UpdateAnnouncementParams extends Equatable {
  final int id;
  final bool? isActive;
  final DateTime? publishedAt;
  final AnnouncementTranslation? translations;

  const UpdateAnnouncementParams({
    required this.id,
    this.isActive,
    this.publishedAt,
    this.translations,
  });

  UpdateAnnouncementParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    AnnouncementTranslation? translations,
  }) {
    return UpdateAnnouncementParams(
      id: id,
      isActive: isActive ?? this.isActive,
      publishedAt: publishedAt ?? this.publishedAt,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'is_active': isActive,
      'published_at': publishedAt?.toIso8601String(),
      'translations': {
        'en': {
          'title': translations?.en.title,
          'content': translations?.en.content,
        },
        'ja': {
          'title': translations?.ja.title,
          'content': translations?.ja.content,
        },
      },
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, isActive, publishedAt, translations];
}
