import 'package:equatable/equatable.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period_statistic.dart';

enum BlockedPeriodStatisticsStatus { initial, loading, success, error }

class BlockedPeriodStatisticsState extends Equatable {
  final BlockedPeriodStatisticsStatus status;
  final BlockedPeriodStatistic? statistics;
  final String? errorMessage;

  const BlockedPeriodStatisticsState({
    this.status = BlockedPeriodStatisticsStatus.initial,
    this.statistics,
    this.errorMessage,
  });

  BlockedPeriodStatisticsState copyWith({
    BlockedPeriodStatisticsStatus? status,
    BlockedPeriodStatistic? statistics,
    String? errorMessage,
  }) {
    return BlockedPeriodStatisticsState(
      status: status ?? this.status,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  BlockedPeriodStatisticsState copyWithClearError() {
    return BlockedPeriodStatisticsState(
      status: status,
      statistics: statistics,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, statistics, errorMessage];
}
