import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/user/presentation/providers/users_notifier.dart';
import 'package:tires/features/user/presentation/providers/users_state.dart';

final usersNotifierProvider = NotifierProvider<UsersNotifier, UsersState>(
  UsersNotifier.new,
);
