import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenWrapper(child: Center(child: AppText('In progress'))),
    );
  }
}
