import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/customer_management/domain/entities/customer.dart';
import 'package:tires/features/customer_management/domain/repositories/customer_repository.dart';

class GetCustomersCursorUsecase
    implements
        Usecase<CursorPaginatedSuccess<Customer>, GetCustomerCursorParams> {
  final CustomerRepository _customerRepository;

  GetCustomersCursorUsecase(this._customerRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Customer>>> call(
    GetCustomerCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get customer cursor usecase');
    return await _customerRepository.getCustomersCursor(params);
  }
}

class GetCustomerCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;
  final String? search;
  final String? status;

  const GetCustomerCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
    this.search,
    this.status,
  });

  GetCustomerCursorParams copyWith({
    bool? paginate,
    int? perPage,
    String? cursor,
    String? search,
    String? status,
  }) {
    return GetCustomerCursorParams(
      paginate: paginate ?? this.paginate,
      perPage: perPage ?? this.perPage,
      cursor: cursor ?? this.cursor,
      search: search ?? this.search,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [paginate, perPage, cursor, search, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate.toString(),
      'per_page': perPage.toString(),
      if (cursor != null) 'cursor': cursor,
      if (search != null && search!.isNotEmpty) 'search': search,
      if (status != null && status != 'all') 'status': status,
    };
  }

  String toJson() => json.encode(toMap());
}
