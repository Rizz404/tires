import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

class UpdateMenuUsecase
    implements Usecase<ItemSuccessResponse<Menu>, UpdateMenuParams> {
  final MenuRepository repository;

  UpdateMenuUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> call(
    UpdateMenuParams params,
  ) {
    return repository.updateMenu(params);
  }
}

class UpdateMenuParams extends Equatable {
  final int id;
  final bool? isActive;
  final DateTime? publishedAt;
  final MenuTranslation? translation;

  const UpdateMenuParams({
    required this.id,
    this.isActive,
    this.publishedAt,
    this.translation,
  });

  UpdateMenuParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    MenuTranslation? translation,
  }) {
    return UpdateMenuParams(
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
          'name': translation?.en.name,
          'description': translation?.en.description,
        },
        'ja': {
          'name': translation?.ja.name,
          'description': translation?.ja.description,
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
