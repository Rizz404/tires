import 'package:equatable/equatable.dart';
import 'package:tires/features/customer_management/domain/entities/customer_detail.dart';

enum CustomerDetailStatus { initial, loading, success, error }

class CustomerDetailState extends Equatable {
  final CustomerDetailStatus status;
  final CustomerDetail? customerDetail;
  final String? errorMessage;

  const CustomerDetailState({
    this.status = CustomerDetailStatus.initial,
    this.customerDetail,
    this.errorMessage,
  });

  CustomerDetailState copyWith({
    CustomerDetailStatus? status,
    CustomerDetail? customerDetail,
    String? errorMessage,
  }) {
    return CustomerDetailState(
      status: status ?? this.status,
      customerDetail: customerDetail ?? this.customerDetail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  CustomerDetailState copyWithClearError() {
    return CustomerDetailState(
      status: status,
      customerDetail: customerDetail,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, customerDetail, errorMessage];
}
