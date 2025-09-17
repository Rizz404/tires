import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';

class CustomerStatisticModel extends CustomerStatistic {
  const CustomerStatisticModel({
    required super.totalCustomers,
    required super.firstTimeCustomers,
    required super.repeatCustomers,
    required super.dormantCustomers,
  });

  factory CustomerStatisticModel.fromMap(Map<String, dynamic> map) {
    return CustomerStatisticModel(
      totalCustomers: map['total_customers'] as int,
      firstTimeCustomers: map['first_time_customers'] as int,
      repeatCustomers: map['repeat_customers'] as int,
      dormantCustomers: map['dormant_customers'] as int,
    );
  }

  factory CustomerStatisticModel.fromJson(String source) =>
      CustomerStatisticModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  Map<String, dynamic> toMap() {
    return {
      'total_customers': totalCustomers,
      'first_time_customers': firstTimeCustomers,
      'repeat_customers': repeatCustomers,
      'dormant_customers': dormantCustomers,
    };
  }

  String toJson() => json.encode(toMap());
}
