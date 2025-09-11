import 'package:equatable/equatable.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final Dashboard? dashboard;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.dashboard,
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    Dashboard? dashboard,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  DashboardState copyWithClearError() {
    return DashboardState(
      status: status,
      dashboard: dashboard,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, errorMessage];
}
