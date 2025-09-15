import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/features/user/domain/entities/blocked_period.dart';

@RoutePage()
class AdminUpsertBlockedPeriodScreen extends StatelessWidget {
  final BlockedPeriod? blockedPeriod;

  const AdminUpsertBlockedPeriodScreen({super.key, this.blockedPeriod});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
