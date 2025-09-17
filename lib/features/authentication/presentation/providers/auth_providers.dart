import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/authentication/presentation/providers/auth_notifier.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
