import 'dart:convert';

import 'package:tires/features/user/domain/entities/menu.dart';

class MenuModel extends Menu {
  const MenuModel({
    required super.id,
    required super.requiredTime,
    super.price,
    required super.color,
    super.photoPath,
    required super.displayOrder,
    required super.isActive,
    required super.translations,
    required super.createdAt,
    required super.updatedAt,
  });

  MenuModel copyWith({
    int? id,
    int? requiredTime,
    double? price,
    String? color,
    String? photoPath,
    int? displayOrder,
    bool? isActive,
    List<MenuTranslationModel>? translations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuModel(
      id: id ?? this.id,
      requiredTime: requiredTime ?? this.requiredTime,
      price: price ?? this.price,
      color: color ?? this.color,
      photoPath: photoPath ?? this.photoPath,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
      translations:
          translations ??
          this.translations
              .map((e) => MenuTranslationModel.fromEntity(e))
              .toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requiredTime': requiredTime,
      'price': price,
      'color': color,
      'photoPath': photoPath,
      'displayOrder': displayOrder,
      'isActive': isActive,
      'translations': translations
          .map((x) => (x as MenuTranslationModel).toMap())
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id']?.toInt() ?? 0,
      requiredTime: map['requiredTime']?.toInt() ?? 0,
      price: map['price']?.toDouble(),
      color: map['color'] ?? '',
      photoPath: map['photoPath'],
      displayOrder: map['displayOrder']?.toInt() ?? 0,
      isActive: map['isActive'] ?? false,
      translations: List<MenuTranslationModel>.from(
        map['translations']?.map((x) => MenuTranslationModel.fromMap(x)),
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory MenuModel.fromEntity(Menu entity) {
    return MenuModel(
      id: entity.id,
      requiredTime: entity.requiredTime,
      price: entity.price,
      color: entity.color,
      photoPath: entity.photoPath,
      displayOrder: entity.displayOrder,
      isActive: entity.isActive,
      translations: entity.translations
          .map((e) => MenuTranslationModel.fromEntity(e))
          .toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source));

  @override
  String toString() => 'MenuModel(${toMap()})';
}

class MenuTranslationModel extends MenuTranslation {
  const MenuTranslationModel({
    required super.id,
    required super.locale,
    required super.name,
    super.description,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MenuTranslationModel.fromEntity(MenuTranslation entity) {
    return MenuTranslationModel(
      id: entity.id,
      locale: entity.locale,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  MenuTranslationModel copyWith({
    int? id,
    String? locale,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuTranslationModel(
      id: id ?? this.id,
      locale: locale ?? this.locale,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'locale': locale,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MenuTranslationModel.fromMap(Map<String, dynamic> map) {
    return MenuTranslationModel(
      id: map['id']?.toInt() ?? 0,
      locale: map['locale'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuTranslationModel.fromJson(String source) =>
      MenuTranslationModel.fromMap(json.decode(source));

  @override
  String toString() => 'MenuTranslationModel(${toMap()})';
}
