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
      'Executing delete announcement usecase for id: ${params.id}',
    );
    return _repository.bulkDeleteAnnouncements(params);
  }
}

class BulkDeleteAnnouncementsUsecaseParams extends Equatable {
  final List<int> id;

  BulkDeleteAnnouncementsUsecaseParams(this.id);

  BulkDeleteAnnouncementsUsecaseParams copyWith({List<int>? id}) {
    return BulkDeleteAnnouncementsUsecaseParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory BulkDeleteAnnouncementsUsecaseParams.fromMap(
    Map<String, dynamic> map,
  ) {
    return BulkDeleteAnnouncementsUsecaseParams(List<int>.from(map['id']));
  }

  String toJson() => json.encode(toMap());

  factory BulkDeleteAnnouncementsUsecaseParams.fromJson(String source) =>
      BulkDeleteAnnouncementsUsecaseParams.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'BulkDeleteAnnouncementsUsecaseParams(id: $id)';
}
