import 'package:tires/features/menu/data/models/menu_model.dart';
import 'package:tires/features/menu/data/models/menu_statistic_model.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/menu/domain/entities/menu_statistic.dart';

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
      translations: (translations as MenuTranslationModel?)?.toEntity(),
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

extension MetaModelMapper on MetaModel {
  Meta toEntity() {
    return Meta(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension MenuTranslationModelMapper on MenuTranslationModel {
  MenuTranslation toEntity() {
    return MenuTranslation(
      en: (en as MenuContentModel?)?.toEntity(),
      ja: (ja as MenuContentModel?)?.toEntity(),
    );
  }
}

extension MenuContentModelMapper on MenuContentModel {
  MenuContent toEntity() {
    return MenuContent(name: name, description: description);
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
      translations: translations?.toModel(),
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

extension MenuTranslationEntityMapper on MenuTranslation {
  MenuTranslationModel toModel() {
    return MenuTranslationModel(
      en: en?.toModel() ?? const MenuContentModel(name: '', description: null),
      ja: ja?.toModel() ?? const MenuContentModel(name: '', description: null),
    );
  }
}

extension MenuContentEntityMapper on MenuContent {
  MenuContentModel toModel() {
    return MenuContentModel(name: name ?? '', description: description);
  }
}

extension MetaEntityMapper on Meta {
  MetaModel toModel() {
    return MetaModel(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension MenuStatisticModelMapper on MenuStatisticModel {
  MenuStatistic toEntity() {
    return MenuStatistic(statistics: statistics.toEntity());
  }
}

extension StatisticsModelMapper on StatisticsModel {
  Statistics toEntity() {
    return Statistics(
      totalMenus: totalMenus,
      activeMenus: activeMenus,
      inactiveMenus: inactiveMenus,
      averagePrice: averagePrice,
    );
  }
}
