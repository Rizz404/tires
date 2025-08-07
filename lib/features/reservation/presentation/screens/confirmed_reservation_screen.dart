import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_app_bar.dart';

@RoutePage()
class ConfirmedReservationScreen extends StatelessWidget {
  const ConfirmedReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(),
      body: ScreenWrapper(child: Center(child: AppText('In progress'))),
    );
  }
}
