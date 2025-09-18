import 'package:equatable/equatable.dart';
import 'package:tires/features/contact/domain/entities/contact_statistic.dart';

enum ContactStatisticsStatus { initial, loading, success, error }

class ContactStatisticsState extends Equatable {
  final ContactStatisticsStatus status;
  final ContactStatistic? statistics;
  final String? errorMessage;

  const ContactStatisticsState({
    this.status = ContactStatisticsStatus.initial,
    this.statistics,
    this.errorMessage,
  });

  ContactStatisticsState copyWith({
    ContactStatisticsStatus? status,
    ContactStatistic? statistics,
    String? errorMessage,
  }) {
    return ContactStatisticsState(
      status: status ?? this.status,
      statistics: statistics ?? this.statistics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  ContactStatisticsState copyWithClearError() {
    return ContactStatisticsState(
      status: status,
      statistics: statistics,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, statistics, errorMessage];
}
