import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';

class BulkDeleteAnnouncementsUsecase
    implements Usecase<ActionSuccess, BulkDeleteAnnouncementsUsecaseParams> {
  final AnnouncementRepository _repository;

  BulkDeleteAnnouncementsUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    BulkDeleteAnnouncementsUsecaseParams params,
  ) {
    AppLogger.businessInfo(
      'Executing delete announcement usecase for ids: ${params.ids}',
    );
    return _repository.bulkDeleteAnnouncements(params);
  }
}

class BulkDeleteAnnouncementsUsecaseParams extends Equatable {
  final List<int> ids;

  BulkDeleteAnnouncementsUsecaseParams(this.ids);

  BulkDeleteAnnouncementsUsecaseParams copyWith({List<int>? ids}) {
    return BulkDeleteAnnouncementsUsecaseParams(ids ?? this.ids);
  }

  Map<String, dynamic> toMap() {
    return {'ids': ids};
  }

  factory BulkDeleteAnnouncementsUsecaseParams.fromMap(
    Map<String, dynamic> map,
  ) {
    return BulkDeleteAnnouncementsUsecaseParams(List<int>.from(map['ids']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteAnnouncementsUsecaseParams.fromJson(String source) =>
      BulkDeleteAnnouncementsUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ids];

  @override
  String toString() => 'BulkDeleteAnnouncementsUsecaseParams(ids: $ids)';
}
