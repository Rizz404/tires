import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum CustomerStatus { initial, loading, loaded, loadingMore, error }

class CustomerState extends Equatable {
  final CustomerStatus status;
  final List<User> customers;
  final String? errorMessage;
  final bool hasNextPage;
  final String? nextCursor;

  const CustomerState({
    this.status = CustomerStatus.initial,
    this.customers = const [],
    this.errorMessage,
    this.hasNextPage = false,
    this.nextCursor,
  });

  CustomerState copyWith({
    CustomerStatus? status,
    List<User>? customers,
    String? errorMessage,
    bool? hasNextPage,
    String? nextCursor,
    bool forceErrorMessageNull = false,
    bool forceNextCursorNull = false,
  }) {
    return CustomerState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      errorMessage: forceErrorMessageNull
          ? null
          : errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      nextCursor: forceNextCursorNull ? null : nextCursor ?? this.nextCursor,
    );
  }

  @override
  List<Object?> get props => [
    status,
    customers,
    errorMessage,
    hasNextPage,
    nextCursor,
  ];
}
