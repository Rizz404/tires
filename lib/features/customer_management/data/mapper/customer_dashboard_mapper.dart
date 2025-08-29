import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/reservation/data/mapper/reservation_mapper.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';

extension CustomerDashboardModelMapper on CustomerDashboardModel {
  CustomerDashboard toEntity() {
    return CustomerDashboard(
      summary: (summary as SummaryModel).toEntity(),
      recentReservations: recentReservations
          .map((reservation) => (reservation as ReservationModel).toEntity())
          .toList(),
    );
  }
}

extension CustomerDashboardEntityMapper on CustomerDashboard {
  CustomerDashboardModel toModel() {
    return CustomerDashboardModel.fromEntity(this);
  }
}

extension SummaryModelMapper on SummaryModel {
  Summary toEntity() {
    return Summary(totalReservations: totalReservations);
  }
}

extension SummaryEntityMapper on Summary {
  SummaryModel toModel() {
    return SummaryModel.fromEntity(this);
  }
}
