import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    super.description,
    required super.requiredTime,
    required PriceModel super.price,
    super.photoPath,
    required super.displayOrder,
    required super.isActive,
    required ColorInfoModel super.color,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      requiredTime: map['required_time'],
      price: PriceModel.fromMap(map['price']),
      photoPath: map['photo_path'],
      displayOrder: map['display_order'],
      isActive: map['is_active'],
      color: ColorInfoModel.fromMap(map['color']),
    );
  }

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'required_time': requiredTime,
      'price': (price as PriceModel).toMap(),
      'photo_path': photoPath,
      'display_order': displayOrder,
      'is_active': isActive,
      'color': (color as ColorInfoModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class PriceModel extends Price {
  const PriceModel({
    required super.amount,
    required super.formatted,
    required super.currency,
  });

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    return PriceModel(
      amount: map['amount'],
      formatted: map['formatted'],
      currency: map['currency'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'formatted': formatted, 'currency': currency};
  }
}

class ColorInfoModel extends ColorInfo {
  const ColorInfoModel({
    required super.hex,
    required super.rgbaLight,
    required super.textColor,
  });

  factory ColorInfoModel.fromMap(Map<String, dynamic> map) {
    return ColorInfoModel(
      hex: map['hex'],
      rgbaLight: map['rgba_light'],
      textColor: map['text_color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'hex': hex, 'rgba_light': rgbaLight, 'text_color': textColor};
  }
}
