import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int requiredTime;
  final Price price;
  final String? photoPath;
  final int displayOrder;
  final bool isActive;
  final ColorInfo color;
  final MenuTranslation? translations;

  const Menu({
    required this.id,
    required this.name,
    this.description,
    required this.requiredTime,
    required this.price,
    this.photoPath,
    required this.displayOrder,
    required this.isActive,
    required this.color,
    this.translations,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    requiredTime,
    price,
    photoPath,
    displayOrder,
    isActive,
    color,
    translations,
  ];
}

class Price extends Equatable {
  final String amount;
  final String formatted;
  final String currency;

  const Price({
    required this.amount,
    required this.formatted,
    required this.currency,
  });

  @override
  List<Object> get props => [amount, formatted, currency];
}

class ColorInfo extends Equatable {
  final String hex;
  final String rgbaLight;
  final String textColor;

  const ColorInfo({
    required this.hex,
    required this.rgbaLight,
    required this.textColor,
  });

  @override
  List<Object?> get props => [hex, rgbaLight, textColor];
}

class MenuTranslation extends Equatable {
  final MenuContent en;
  final MenuContent ja;

  const MenuTranslation({required this.en, required this.ja});

  @override
  List<Object> get props => [en, ja];
}

class MenuContent extends Equatable {
  final String name;
  final String? description;

  const MenuContent({required this.name, this.description});

  @override
  List<Object?> get props => [name, description];
}

class Meta extends Equatable {
  final String locale;
  final bool fallbackUsed;

  Meta({required this.locale, required this.fallbackUsed});

  @override
  List<Object> get props => [locale, fallbackUsed];
}
