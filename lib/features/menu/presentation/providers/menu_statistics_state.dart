import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu_statistic.dart';

enum MenuStatisticsStatus { initial, loading, success, error }

class MenuStatisticsState extends Equatable {
  final MenuStatisticsStatus status;
  final MenuStatistic? statistics;
  final String? errorMessage;

  const MenuStatisticsState({
    this.status = MenuStatisticsStatus.initial,
    this.statistics,
    this.errorMessage,
  });

  MenuStatisticsState copyWith({
    MenuStatisticsStatus? status,
    MenuStatistic? statistics,
    String? errorMessage,
  }) {
    return MenuStatisticsState(
      status: status ?? this.status,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  MenuStatisticsState copyWithClearError() {
    return MenuStatisticsState(
      status: status,
      statistics: statistics,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, statistics, errorMessage];
}
