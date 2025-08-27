import 'package:tires/features/customer_management/data/models/customer_model.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';

extension CustomerModelMapper on CustomerModel {
  Customer toEntity() {
    return Customer(
      id: id,
      name: name,
      description: description,
      requiredTime: requiredTime,
      price: (price as PriceModel).toEntity(),
      photoPath: photoPath,
      displayOrder: displayOrder,
      isActive: isActive,
      color: (color as ColorInfoModel).toEntity(),
    );
  }
}

extension PriceModelMapper on PriceModel {
  Price toEntity() {
    return Price(amount: amount, formatted: formatted, currency: currency);
  }
}

extension ColorInfoModelMapper on ColorInfoModel {
  ColorInfo toEntity() {
    return ColorInfo(hex: hex, rgbaLight: rgbaLight, textColor: textColor);
  }
}

extension CustomerEntityMapper on Customer {
  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      name: name,
      description: description,
      requiredTime: requiredTime,
      price: price.toModel(),
      photoPath: photoPath,
      displayOrder: displayOrder,
      isActive: isActive,
      color: color.toModel(),
    );
  }
}

extension PriceEntityMapper on Price {
  PriceModel toModel() {
    return PriceModel(amount: amount, formatted: formatted, currency: currency);
  }
}

extension ColorInfoEntityMapper on ColorInfo {
  ColorInfoModel toModel() {
    return ColorInfoModel(hex: hex, rgbaLight: rgbaLight, textColor: textColor);
  }
}
