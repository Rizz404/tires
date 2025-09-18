import 'dart:convert';

import 'package:tires/features/contact/domain/entities/contact_statistic.dart';

class ContactStatisticModel {
  final int total;
  final int pending;
  final int replied;
  final int today;

  ContactStatisticModel({
    required this.total,
    required this.pending,
    required this.replied,
    required this.today,
  });

  factory ContactStatisticModel.fromMap(Map<String, dynamic> map) {
    return ContactStatisticModel(
      total: map['total'] as int,
      pending: map['pending'] as int,
      replied: map['replied'] as int,
      today: map['today'] as int? ?? 0,
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
