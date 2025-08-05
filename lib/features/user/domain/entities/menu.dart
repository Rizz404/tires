import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final int id;
  final int requiredTime;
  final double? price;
  final String color;
  final String? photoPath;
  final int displayOrder;
  final bool isActive;
  final List<MenuTranslation> translations;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Menu({
    required this.id,
    required this.requiredTime,
    this.price,
    required this.color,
    this.photoPath,
    required this.displayOrder,
    required this.isActive,
    required this.translations,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    requiredTime,
    price,
    color,
    photoPath,
    displayOrder,
    isActive,
    translations,
    createdAt,
    updatedAt,
  ];
}

class MenuTranslation extends Equatable {
  final int id;
  final String locale;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MenuTranslation({
    required this.id,
    required this.locale,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    locale,
    name,
    description,
    createdAt,
    updatedAt,
  ];
}
