import 'dart:convert';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/reservation/data/mapper/reservation_mapper.dart';

class CustomerDashboardModel extends CustomerDashboard {
  const CustomerDashboardModel({
    required super.summary,
    required super.recentReservations,
  });

  factory CustomerDashboardModel.fromMap(Map<String, dynamic> map) {
    final summaryData = map['summary'] as Map<String, dynamic>? ?? {};
    final recentReservationsData =
        (map['recent_reservations'] as List<dynamic>?) ?? <dynamic>[];

    return CustomerDashboardModel(
      summary: SummaryModel.fromMap(summaryData),
      recentReservations: recentReservationsData
          .map((item) => ReservationModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory CustomerDashboardModel.fromEntity(CustomerDashboard entity) {
    return CustomerDashboardModel(
      summary: SummaryModel.fromEntity(entity.summary),
      recentReservations: entity.recentReservations
          .map((reservation) => reservation.toModel())
          .toList(),
    );
  }

  factory CustomerDashboardModel.fromJson(String source) =>
      CustomerDashboardModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'summary': (summary as SummaryModel).toMap(),
      'recent_reservations': recentReservations
          .map((reservation) => (reservation as ReservationModel).toMap())
          .toList(),
    };
  }

  String toJson() => json.encode(toMap());

  CustomerDashboardModel copyWith({
    SummaryModel? summary,
    List<ReservationModel>? recentReservations,
  }) {
    return CustomerDashboardModel(
      summary: summary ?? this.summary,
      recentReservations: recentReservations ?? this.recentReservations,
    );
  }

  @override
  String toString() => 'CustomerDashboardModel(${toMap()})';
}

class SummaryModel extends Summary {
  SummaryModel({
    required super.totalReservations,
    required super.pendingReservations,
    required super.completedReservations,
  });

  factory SummaryModel.fromMap(Map<String, dynamic> map) {
    return SummaryModel(
      totalReservations: (map['total_reservations'] as int?) ?? 0,
      pendingReservations: (map['pending_reservations'] as int?) ?? 0,
      completedReservations: (map['completed_reservations'] as int?) ?? 0,
    );
  }

  factory SummaryModel.fromEntity(Summary entity) {
    return SummaryModel(
      totalReservations: entity.totalReservations,
      pendingReservations: entity.pendingReservations,
      completedReservations: entity.completedReservations,
    );
  }

  factory SummaryModel.fromJson(String source) =>
      SummaryModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'total_reservations': totalReservations,
      'pending_reservations': pendingReservations,
      'completed_reservations': completedReservations,
    };
  }

  String toJson() => json.encode(toMap());

  SummaryModel copyWith({
    int? totalReservations,
    int? pendingReservations,
    int? completedReservations,
  }) {
    return SummaryModel(
      totalReservations: totalReservations ?? this.totalReservations,
      pendingReservations: pendingReservations ?? this.pendingReservations,
      completedReservations:
          completedReservations ?? this.completedReservations,
    );
  }

  @override
  String toString() =>
      'SummaryModel(totalReservations: $totalReservations, pendingReservations: $pendingReservations, completedReservations: $completedReservations)';
}
