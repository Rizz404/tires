import 'package:tires/features/announcement/data/models/announcement_model.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

extension AnnouncementModelMapper on AnnouncementModel {
  Announcement toEntity() {
    return Announcement(
      id: id,
      title: title,
      content: content,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      meta: (meta as MetaModel).toEntity(),
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
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      meta: meta.toModel(),
    );
  }
}

extension MetaEntityMapper on Meta {
  MetaModel toModel() {
    return MetaModel(locale: locale, fallbackUsed: fallbackUsed);
  }
}
