import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/repositories/menu_repository.dart';

class CreateMenuUsecase
    implements Usecase<ItemSuccessResponse<Menu>, CreateMenuParams> {
  final MenuRepository repository;

  CreateMenuUsecase(this.repository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Menu>>> call(
    CreateMenuParams params,
  ) {
    AppLogger.businessInfo('Executing create menu usecase');
    return repository.createMenu(params);
  }
}

class CreateMenuParams extends Equatable {
  final int requiredTime;
  final int price;
  final String photoPath;
  final int displayOrder;
  final bool isActive;
  final String color;
  final MenuTranslation translations;

  const CreateMenuParams({
    required this.requiredTime,
    required this.price,
    required this.photoPath,
    required this.displayOrder,
    required this.isActive,
    required this.color,
    required this.translations,
  });

  CreateMenuParams copyWith({
    int? requiredTime,
    int? price,
    String? photoPath,
    int? displayOrder,
    bool? isActive,
    String? color,
    MenuTranslation? translations,
  }) {
    return CreateMenuParams(
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
      'required_time': requiredTime,
      'price': price,
      'photo_path': photoPath,
      'display_order': displayOrder,
      'is_active': isActive,
      'color': color,
      'translations': translations.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      requiredTime,
      price,
      photoPath,
      displayOrder,
      isActive,
      color,
      translations,
    ];
  }

  factory CreateMenuParams.fromMap(Map<String, dynamic> map) {
    return CreateMenuParams(
      requiredTime: map['required_time'] as int,
      price: map['price'] as int,
      photoPath: map['photo_path'] as String,
      displayOrder: map['display_order'] as int,
      isActive: map['is_active'] as bool,
      color: map['color'] as String,
      translations: MenuTranslation.fromMap(
        map['translations'] as Map<String, dynamic>,
      ),
    );
  }

  factory CreateMenuParams.fromJson(String source) =>
      CreateMenuParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
