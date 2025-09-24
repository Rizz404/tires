import 'package:tires/features/blocked_period/data/models/blocked_period_model.dart';
import 'package:tires/features/blocked_period/data/models/blocked_period_statistic_model.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_translation.dart';

extension BlockedPeriodModelMapper on BlockedPeriodModel {
  BlockedPeriod toEntity() {
    return BlockedPeriod(
      id: id,
      menuId: menuId,
      startDatetime: startDatetime,
      endDatetime: endDatetime,
      reason: reason,
      allMenuForBlockedPeriods: allMenuForBlockedPeriods,
      createdAt: createdAt,
      updatedAt: updatedAt,
      menu: (menu as MenuModelForBlockedPeriod?)?.toEntity(),
      duration: (duration as DurationModel).toEntity(),
      status: status,
      translations: (translations as BlockedPeriodTranslationModel?)
          ?.toEntity(),
      meta: (meta as MetaModel).toEntity(),
    );
  }
}

extension MenuModelForBlockedPeriodMapper on MenuModelForBlockedPeriod {
  MenuForBlockedPeriod toEntity() {
    return MenuForBlockedPeriod(id: id, name: name, color: color);
  }
}

extension DurationModelMapper on DurationModel {
  Duration toEntity() {
    return Duration(
      hours: hours,
      minutes: minutes,
      text: text,
      isShort: isShort,
    );
  }
}

extension MetaModelMapper on MetaModel {
  Meta toEntity() {
    return Meta(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension BlockedPeriodTranslationModelMapper on BlockedPeriodTranslationModel {
  BlockedPeriodTranslation toEntity() {
    return BlockedPeriodTranslation(
      en: (en as BlockedPeriodContentModel).toEntity(),
      ja: (ja as BlockedPeriodContentModel).toEntity(),
    );
  }
}

extension BlockedPeriodContentModelMapper on BlockedPeriodContentModel {
  BlockedPeriodContent toEntity() {
    return BlockedPeriodContent(reason: reason);
  }
}

extension BlockedPeriodStatisticModelMapper on BlockedPeriodStatisticModel {
  BlockedPeriodStatistic toEntity() {
    return BlockedPeriodStatistic(
      total: total,
      active: active,
      upcoming: upcoming,
      expired: expired,
      allMenus: allMenus,
      specificMenus: specificMenus,
      totalDurationHours: totalDurationHours,
    );
  }
}

// Entity to Model mappers
extension BlockedPeriodEntityMapper on BlockedPeriod {
  BlockedPeriodModel toModel() {
    return BlockedPeriodModel(
      id: id,
      menuId: menuId,
      startDatetime: startDatetime,
      endDatetime: endDatetime,
      reason: reason,
      allMenuForBlockedPeriods: allMenuForBlockedPeriods,
      createdAt: createdAt,
      updatedAt: updatedAt,
      menu: menu?.toModel(),
      duration: duration.toModel(),
      status: status,
      translations: translations?.toModel(),
      meta: meta.toModel(),
    );
  }
}

extension MenuEntityMapper on MenuForBlockedPeriod {
  MenuModelForBlockedPeriod toModel() {
    return MenuModelForBlockedPeriod(id: id, name: name, color: color);
  }
}

extension DurationEntityMapper on Duration {
  DurationModel toModel() {
    return DurationModel(
      hours: hours,
      minutes: minutes,
      text: text,
      isShort: isShort,
    );
  }
}

extension MetaEntityMapper on Meta {
  MetaModel toModel() {
    return MetaModel(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension BlockedPeriodTranslationEntityMapper on BlockedPeriodTranslation {
  BlockedPeriodTranslationModel toModel() {
    return BlockedPeriodTranslationModel(en: en.toModel(), ja: ja.toModel());
  }
}

extension BlockedPeriodContentEntityMapper on BlockedPeriodContent {
  BlockedPeriodContentModel toModel() {
    return BlockedPeriodContentModel(reason: reason);
  }
}

extension BlockedPeriodStatisticEntityMapper on BlockedPeriodStatistic {
  BlockedPeriodStatisticModel toModel() {
    return BlockedPeriodStatisticModel(
      total: total,
      active: active,
      upcoming: upcoming,
      expired: expired,
      allMenus: allMenus,
      specificMenus: specificMenus,
      totalDurationHours: totalDurationHours,
    );
  }
}
