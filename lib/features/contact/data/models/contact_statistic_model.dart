import 'dart:convert';

import 'package:tires/features/contact/domain/entities/contact_statistic.dart';

class ContactStatisticModel {
  final num total;
  final num pending;
  final num replied;
  final num today;

  ContactStatisticModel({
    required this.total,
    required this.pending,
    required this.replied,
    required this.today,
  });

  factory ContactStatisticModel.fromMap(Map<String, dynamic> map) {
    return ContactStatisticModel(
      total: map['total'] as num,
      pending: map['pending'] as num,
      replied: map['replied'] as num,
      today: map['today'] as num? ?? 0,
    );
  }

  factory ContactStatisticModel.fromJson(String source) =>
      ContactStatisticModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  ContactStatistic toEntity() {
    return ContactStatistic(
      statistics: Statistics(
        total: total,
        pending: pending,
        replied: replied,
        today: today,
      ),
    );
  }
}
