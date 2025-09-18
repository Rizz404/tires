import 'package:tires/features/customer_management/data/models/customer_statistic_model.dart';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';

extension CustomerStatisticModelMapper on CustomerStatisticModel {
  CustomerStatistic toEntity() {
    return CustomerStatistic(
      totalCustomers: totalCustomers,
      firstTime: firstTime,
      repeat: repeat,
      dormant: dormant,
    );
  }
}

extension CustomerStatisticEntityMapper on CustomerStatistic {
  CustomerStatisticModel toModel() {
    return CustomerStatisticModel(
      totalCustomers: totalCustomers,
      firstTime: firstTime,
      repeat: repeat,
      dormant: dormant,
    );
  }
}
