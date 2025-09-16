import 'package:equatable/equatable.dart';
import 'package:tires/features/announcement/domain/entities/announcement_statistic.dart';

enum AnnouncementStatisticsStatus { initial, loading, success, error }

class AnnouncementStatisticsState extends Equatable {
  final AnnouncementStatisticsStatus status;
  final AnnouncementStatistic? statistics;
  final String? errorMessage;

  const AnnouncementStatisticsState({
    this.status = AnnouncementStatisticsStatus.initial,
    this.statistics,
    this.errorMessage,
  });

  AnnouncementStatisticsState copyWith({
    AnnouncementStatisticsStatus? status,
    AnnouncementStatistic? statistics,
    String? errorMessage,
  }) {
    return AnnouncementStatisticsState(
      status: status ?? this.status,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AnnouncementStatisticsState copyWithClearError() {
    return AnnouncementStatisticsState(
      status: status,
      statistics: statistics,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, statistics, errorMessage];
}
