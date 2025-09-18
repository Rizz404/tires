import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';

class CustomerStatisticModel extends CustomerStatistic {
  const CustomerStatisticModel({
    required super.totalCustomers,
    required super.firstTime,
    required super.repeat,
    required super.dormant,
  });

  factory CustomerStatisticModel.fromMap(Map<String, dynamic> map) {
    final data = map['data'] as Map<String, dynamic>;
    final statistics = data['statistics'] as Map<String, dynamic>;

    return CustomerStatisticModel(
      totalCustomers: data['total_customers'] as int,
      firstTime: statistics['first_time'] as int,
      repeat: statistics['repeat'] as int,
      dormant: statistics['dormant'] as int,
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
          'first_time': firstTime,
          'repeat': repeat,
          'dormant': dormant,
        },
        'total_customers': totalCustomers,
      },
    };
  }

  String toJson() => json.encode(toMap());
}
