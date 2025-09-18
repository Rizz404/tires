import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum CustomersStatus { initial, loading, success, error, loadingMore }

class CustomersState extends Equatable {
  final CustomersStatus status;
  final List<User> customers;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const CustomersState({
    this.status = CustomersStatus.initial,
    this.customers = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  CustomersState copyWith({
    CustomersStatus? status,
    List<User>? customers,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return CustomersState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  CustomersState copyWithClearError() {
    return CustomersState(
      status: status,
      customers: customers,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    customers,
    cursor,
    errorMessage,
    hasNextPage,
  ];
}
