import 'package:equatable/equatable.dart';
import 'package:tires/features/customer_management/domain/entities/customer_dashboard.dart';

enum CurrentUserDashboardGetStatus { initial, loading, success, error }

class CurrentUserDashboardGetState extends Equatable {
  final CurrentUserDashboardGetStatus status;
  final CustomerDashboard? dashboard;
  final String? errorMessage;

  const CurrentUserDashboardGetState({
    this.status = CurrentUserDashboardGetStatus.initial,
    this.dashboard,
    this.errorMessage,
  });

  CurrentUserDashboardGetState copyWith({
    CurrentUserDashboardGetStatus? status,
    CustomerDashboard? dashboard,
    String? errorMessage,
  }) {
    return CurrentUserDashboardGetState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  CurrentUserDashboardGetState copyWithClearError() {
    return CurrentUserDashboardGetState(
      status: status,
      dashboard: dashboard,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, errorMessage];
}
