import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/features/contact/domain/entities/contact.dart';

@RoutePage()
class AdminUpsertContactScreen extends StatelessWidget {
  final Contact? contact;

  const AdminUpsertContactScreen({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
