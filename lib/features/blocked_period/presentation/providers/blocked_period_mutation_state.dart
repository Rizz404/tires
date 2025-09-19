import 'package:equatable/equatable.dart';
import 'package:tires/features/blocked_period/domain/entities/blocked_period.dart';

enum BlockedPeriodMutationStatus { initial, loading, success, error }

class BlockedPeriodMutationState extends Equatable {
  final BlockedPeriodMutationStatus status;
  final BlockedPeriod? blockedPeriod;
  final String? errorMessage;

  const BlockedPeriodMutationState({
    this.status = BlockedPeriodMutationStatus.initial,
    this.blockedPeriod,
    this.errorMessage,
  });

  BlockedPeriodMutationState copyWith({
    BlockedPeriodMutationStatus? status,
    BlockedPeriod? blockedPeriod,
    String? errorMessage,
  }) {
    return BlockedPeriodMutationState(
      status: status ?? this.status,
      blockedPeriod: blockedPeriod ?? this.blockedPeriod,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  BlockedPeriodMutationState copyWithClearError() {
    return BlockedPeriodMutationState(
      status: status,
      blockedPeriod: blockedPeriod,
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [status, blockedPeriod, errorMessage];
}
