// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class UpdateMenuUsecase
    implements Usecase<ItemSuccessResponse<Menu>, UpdateMenuParams> {
  final MenuRepository repository;

  UpdateMenuUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> call(
    UpdateMenuParams params,
  ) {
    AppLogger.businessInfo(
      'Executing update menu usecase for id: ${params.id}',
    );
    return repository.updateMenu(params);
  }
}

class UpdateMenuParams extends Equatable {
  final int id;
  final int? requiredTime;
  final int? price;
  final String? photoPath;
  final int? displayOrder;
  final bool? isActive;
  final String? color;
  final MenuTranslation? translations;

  const UpdateMenuParams({
    required this.id,
    this.requiredTime,
    this.price,
    this.photoPath,
    this.displayOrder,
    this.isActive,
    this.color,
    this.translations,
  });

  UpdateMenuParams copyWith({
    int? id,
    int? requiredTime,
    int? price,
    String? photoPath,
    int? displayOrder,
    bool? isActive,
    String? color,
    MenuTranslation? translations,
  }) {
    return UpdateMenuParams(
      id: id ?? this.id,
      requiredTime: requiredTime ?? this.requiredTime,
      price: price ?? this.price,
      photoPath: photoPath ?? this.photoPath,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
      color: color ?? this.color,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'required_time': requiredTime,
      'price': price,
      'photo_path': photoPath,
      'display_order': displayOrder,
      'is_active': isActive,
      'color': color,
      'translations': translations?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      requiredTime,
      price,
      photoPath,
      displayOrder,
      isActive,
      color,
      translations,
    ];
  }

  factory UpdateMenuParams.fromMap(Map<String, dynamic> map) {
    return UpdateMenuParams(
      id: map['id'] as int,
      requiredTime: map['required_time'] != null
          ? map['required_time'] as int
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      photoPath: map['photo_path'] != null ? map['photo_path'] as String : null,
      displayOrder: map['display_order'] != null
          ? map['display_order'] as int
          : null,
      isActive: map['is_active'] != null ? map['is_active'] as bool : null,
      color: map['color'] != null ? map['color'] as String : null,
      translations: map['translations'] != null
          ? MenuTranslation.fromMap(map['translations'] as Map<String, dynamic>)
          : null,
    );
  }

  factory UpdateMenuParams.fromJson(String source) =>
      UpdateMenuParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
