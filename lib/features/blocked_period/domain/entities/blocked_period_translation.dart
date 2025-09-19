import 'package:equatable/equatable.dart';

class BlockedPeriodTranslation extends Equatable {
  final BlockedPeriodContent en;
  final BlockedPeriodContent ja;

  const BlockedPeriodTranslation({
    required this.en,
    required this.ja,
  });

  @override
  List<Object> get props => [en, ja];
}

class BlockedPeriodContent extends Equatable {
  final String reason;

  const BlockedPeriodContent({
    required this.reason,
  });

  @override
  List<Object> get props => [reason];
}
