import 'package:equatable/equatable.dart';
import 'package:tires/features/customer_management/domain/entities/customer_statistic.dart';

enum CustomerStatisticsStatus { initial, loading, success, error }

class CustomerStatisticsState extends Equatable {
  final CustomerStatisticsStatus status;
  final CustomerStatistic? statistics;
  final String? errorMessage;

  const CustomerStatisticsState({
    this.status = CustomerStatisticsStatus.initial,
    this.statistics,
    this.errorMessage,
  });

  CustomerStatisticsState copyWith({
    CustomerStatisticsStatus? status,
    CustomerStatistic? statistics,
    String? errorMessage,
  }) {
    return CustomerStatisticsState(
      status: status ?? this.status,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  CustomerStatisticsState copyWithClearError() {
    return CustomerStatisticsState(
      status: status,
      statistics: statistics,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, statistics, errorMessage];
}
