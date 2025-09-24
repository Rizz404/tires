import 'package:equatable/equatable.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_translation.dart';

class BlockedPeriod extends Equatable {
  final int id;
  final int? menuId;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String reason;
  final bool allMenuForBlockedPeriods;
  final DateTime createdAt;
  final DateTime updatedAt;
  final MenuForBlockedPeriod? menu;
  final Duration duration;
  final String status;
  final BlockedPeriodTranslation? translations;
  final Meta meta;

  const BlockedPeriod({
    required this.id,
    this.menuId,
    required this.startDatetime,
    required this.endDatetime,
    required this.reason,
    required this.allMenuForBlockedPeriods,
    required this.createdAt,
    required this.updatedAt,
    this.menu,
    required this.duration,
    required this.status,
    this.translations,
    required this.meta,
  });

  @override
  List<Object?> get props => [
    id,
    menuId,
    startDatetime,
    endDatetime,
    reason,
    allMenuForBlockedPeriods,
    createdAt,
    updatedAt,
    menu,
    duration,
    status,
    translations,
    meta,
  ];
}

class MenuForBlockedPeriod extends Equatable {
  final int id;
  final String name;
  final String color;

  const MenuForBlockedPeriod({
    required this.id,
    required this.name,
    required this.color,
  });

  @override
  List<Object> get props => [id, name, color];
}

class Duration extends Equatable {
  final int hours;
  final int minutes;
  final String text;
  final bool isShort;

  const Duration({
    required this.hours,
    required this.minutes,
    required this.text,
    required this.isShort,
  });

  @override
  List<Object> get props => [hours, minutes, text, isShort];
}

class Meta extends Equatable {
  final String locale;
  final bool fallbackUsed;

  const Meta({required this.locale, required this.fallbackUsed});

  @override
  List<Object> get props => [locale, fallbackUsed];
}
