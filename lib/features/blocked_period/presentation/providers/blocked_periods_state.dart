import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';

enum BlockedPeriodsStatus { initial, loading, success, error, loadingMore }

class BlockedPeriodsState extends Equatable {
  final BlockedPeriodsStatus status;
  final List<BlockedPeriod> blockedPeriods;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const BlockedPeriodsState({
    this.status = BlockedPeriodsStatus.initial,
    this.blockedPeriods = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  BlockedPeriodsState copyWith({
    BlockedPeriodsStatus? status,
    List<BlockedPeriod>? blockedPeriods,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return BlockedPeriodsState(
      status: status ?? this.status,
      blockedPeriods: blockedPeriods ?? this.blockedPeriods,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  BlockedPeriodsState copyWithClearError() {
    return BlockedPeriodsState(
      status: status,
      blockedPeriods: blockedPeriods,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    blockedPeriods,
    cursor,
    errorMessage,
    hasNextPage,
  ];
}
