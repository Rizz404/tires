import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/announcement/data/models/announcement_statistic_model.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';
import 'package:tires/features/announcement/domain/entities/announcement_translation.dart';

extension AnnouncementModelMapper on AnnouncementModel {
  Announcement toEntity() {
    return Announcement(
      id: id,
      title: title,
      content: content,
      publishedAt: publishedAt,
      isActive: isActive,
      meta: (meta as MetaModel).toEntity(),
      translations: (translations as AnnouncementTranslationModel?)?.toEntity(),
    );
  }
}

extension MetaModelMapper on MetaModel {
  Meta toEntity() {
    return Meta(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension AnnouncementEntityMapper on Announcement {
  AnnouncementModel toModel() {
    return AnnouncementModel(
      id: id,
      title: title,
      content: content,
      publishedAt: publishedAt,
      isActive: isActive,
      meta: meta.toModel(),
      translations: translations?.toModel(),
    );
  }
}

extension MetaEntityMapper on Meta {
  MetaModel toModel() {
    return MetaModel(locale: locale, fallbackUsed: fallbackUsed);
  }
}

extension AnnouncementTranslationModelMapper on AnnouncementTranslationModel {
  AnnouncementTranslation toEntity() {
    return AnnouncementTranslation(
      en: (en as AnnouncementContentModel).toEntity(),
      ja: (ja as AnnouncementContentModel).toEntity(),
    );
  }
}

extension AnnouncementContentModelMapper on AnnouncementContentModel {
  AnnouncementContent toEntity() {
    return AnnouncementContent(title: title, content: content);
  }
}

extension AnnouncementTranslationEntityMapper on AnnouncementTranslation {
  AnnouncementTranslationModel toModel() {
    return AnnouncementTranslationModel(en: en.toModel(), ja: ja.toModel());
  }
}

extension AnnouncementContentEntityMapper on AnnouncementContent {
  AnnouncementContentModel toModel() {
    return AnnouncementContentModel(title: title, content: content);
  }
}

extension AnnouncementStatisticModelMapper on AnnouncementStatisticModel {
  AnnouncementStatistic toEntity() {
    return AnnouncementStatistic(
      totalAnnouncements: totalAnnouncements,
      active: active,
      inactive: inactive,
      today: today,
    );
  }
}

extension AnnouncementStatisticEntityMapper on AnnouncementStatistic {
  AnnouncementStatisticModel toModel() {
    return AnnouncementStatisticModel(
      totalAnnouncements: totalAnnouncements,
      active: active,
      inactive: inactive,
      today: today,
    );
  }
}
