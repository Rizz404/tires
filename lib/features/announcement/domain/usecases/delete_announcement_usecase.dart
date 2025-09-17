import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/announcement/domain/repositories/announcement_repository.dart';

class DeleteAnnouncementUsecase
    implements Usecase<ActionSuccess, DeleteAnnouncementParams> {
  final AnnouncementRepository _repository;

  DeleteAnnouncementUsecase(this._repository);

  @override
  Future<Either<Failure, ActionSuccess>> call(DeleteAnnouncementParams params) {
    AppLogger.businessInfo(
      'Executing delete announcement usecase for id: ${params.id}',
    );
    return _repository.deleteAnnouncement(params);
  }
}

class DeleteAnnouncementParams extends Equatable {
  final int id;

  DeleteAnnouncementParams(this.id);

  DeleteAnnouncementParams copyWith({int? id}) {
    return DeleteAnnouncementParams(id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  factory DeleteAnnouncementParams.fromMap(Map<String, dynamic> map) {
    return DeleteAnnouncementParams(map['id'] as int);
  }

  String toJson() => json.encode(toMap());

  factory DeleteAnnouncementParams.fromJson(String source) =>
      DeleteAnnouncementParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}
