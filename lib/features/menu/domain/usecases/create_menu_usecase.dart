import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

class CreateMenuUsecase
    implements Usecase<ItemSuccessResponse<Menu>, CreateMenuParams> {
  final MenuRepository repository;

  CreateMenuUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> call(
    CreateMenuParams params,
  ) {
    return repository.createMenu(params);
  }
}

class CreateMenuParams extends Equatable {
  final bool isActive;
  final DateTime publishedAt;
  final MenuTranslation? translations;

  const CreateMenuParams({
    required this.isActive,
    required this.publishedAt,
    this.translations,
  });

  CreateMenuParams copyWith({
    bool? isActive,
    DateTime? publishedAt,
    MenuTranslation? translations,
  }) {
    return CreateMenuParams(
      isActive: isActive ?? this.isActive,
      publishedAt: publishedAt ?? this.publishedAt,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'publishedAt': publishedAt.toIso8601String(),
      'translations': {
        'en': {
          'name': translations?.en.name,
          'description': translations?.en.description,
        },
        'ja': {
          'name': translations?.ja.name,
          'description': translations?.ja.description,
        },
      },
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isActive, publishedAt, translations];
}
