import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

extension MenuModelMapper on MenuModel {
  Menu toEntity() {
    return Menu(
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

extension MenuEntityMapper on Menu {
  MenuModel toModel() {
    return MenuModel(
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
