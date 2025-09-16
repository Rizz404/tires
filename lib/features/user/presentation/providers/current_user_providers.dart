import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_notifier.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_state.dart';

final currentUserGetNotifierProvider =
    NotifierProvider<CurrentUserGetNotifier, CurrentUserGetState>(
      CurrentUserGetNotifier.new,
    );

final currentUserMutationNotifierProvider =
    NotifierProvider<CurrentUserMutationNotifier, CurrentUserMutationState>(
      CurrentUserMutationNotifier.new,
    );
