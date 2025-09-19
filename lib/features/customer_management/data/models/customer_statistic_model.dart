import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';

class CustomerStatisticModel extends CustomerStatistic {
  const CustomerStatisticModel({
    required super.totalCustomers,
    required super.statistics,
  });

  factory CustomerStatisticModel.fromMap(Map<String, dynamic> map) {
    final statistics = map['statistics'] as Map<String, dynamic>;

    return CustomerStatisticModel(
      totalCustomers: map['total_customers'] as int,
      statistics: Statistic(
        firstTime: statistics['first_time'] as int,
        repeat: statistics['repeat'] as int,
        dormant: statistics['dormant'] as int,
      ),
    );
  }

  factory CustomerStatisticModel.fromJson(String source) =>
      CustomerStatisticModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  Map<String, dynamic> toMap() {
    return {
      'status': 'success',
      'message': 'Customer statistics retrieved successfully',
      'data': {
        'statistics': {
          'first_time': statistics.firstTime,
          'repeat': statistics.repeat,
          'dormant': statistics.dormant,
        },
        'total_customers': totalCustomers,
      },
    };
  }

  String toJson() => json.encode(toMap());
}
