import 'package:flutter/material.dart';

class BusinessDayHours {
  final bool closed;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  const BusinessDayHours({required this.closed, this.openTime, this.closeTime});

  factory BusinessDayHours.fromMap(Map<String, dynamic> map) {
    final closed = map['closed'] as bool? ?? false;
    TimeOfDay? openTime;
    TimeOfDay? closeTime;

    if (!closed) {
      if (map['open'] != null) {
        final openParts = (map['open'] as String).split(':');
        openTime = TimeOfDay(
          hour: int.parse(openParts[0]),
          minute: int.parse(openParts[1]),
        );
      }
      if (map['close'] != null) {
        final closeParts = (map['close'] as String).split(':');
        closeTime = TimeOfDay(
          hour: int.parse(closeParts[0]),
          minute: int.parse(closeParts[1]),
        );
      }
    }

    return BusinessDayHours(
      closed: closed,
      openTime: openTime,
      closeTime: closeTime,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'closed': closed};
    if (!closed && openTime != null) {
      map['open'] =
          '${openTime!.hour.toString().padLeft(2, '0')}:${openTime!.minute.toString().padLeft(2, '0')}';
    }
    if (!closed && closeTime != null) {
      map['close'] =
          '${closeTime!.hour.toString().padLeft(2, '0')}:${closeTime!.minute.toString().padLeft(2, '0')}';
    }
    return map;
  }

  BusinessDayHours copyWith({
    bool? closed,
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
  }) {
    return BusinessDayHours(
      closed: closed ?? this.closed,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  @override
  String toString() {
    return 'BusinessDayHours(closed: $closed, openTime: $openTime, closeTime: $closeTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BusinessDayHours &&
        other.closed == closed &&
        other.openTime == openTime &&
        other.closeTime == closeTime;
  }

  @override
  int get hashCode => closed.hashCode ^ openTime.hashCode ^ closeTime.hashCode;
}
