import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_mutation_notifier.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_mutation_state.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_periods_notifier.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_periods_state.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_statistics_notifier.dart';
import 'package:tires/features/blocked_period/presentation/providers/blocked_period_statistics_state.dart';

final blockedPeriodGetNotifierProvider =
    NotifierProvider<BlockedPeriodsNotifier, BlockedPeriodsState>(
      BlockedPeriodsNotifier.new,
    );

final blockedPeriodMutationNotifierProvider =
    NotifierProvider<BlockedPeriodMutationNotifier, BlockedPeriodMutationState>(
      BlockedPeriodMutationNotifier.new,
    );

final blockedPeriodStatisticsNotifierProvider =
    NotifierProvider<
      BlockedPeriodStatisticsNotifier,
      BlockedPeriodStatisticsState
    >(BlockedPeriodStatisticsNotifier.new);
