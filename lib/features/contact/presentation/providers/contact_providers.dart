import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/contact/presentation/providers/contact_mutation_notifier.dart';
import 'package:tires/features/contact/presentation/providers/contact_mutation_state.dart';
import 'package:tires/features/contact/presentation/providers/contacts_notifier.dart';
import 'package:tires/features/contact/presentation/providers/contacts_state.dart';
import 'package:tires/features/contact/presentation/providers/contact_statistics_notifier.dart';
import 'package:tires/features/contact/presentation/providers/contact_statistics_state.dart';
import 'package:tires/features/contact/presentation/providers/contacts_search_notifier.dart';

final contactGetNotifierProvider =
    NotifierProvider<ContactsNotifier, ContactsState>(ContactsNotifier.new);

final contactMutationNotifierProvider =
    NotifierProvider<ContactMutationNotifier, ContactMutationState>(
      ContactMutationNotifier.new,
    );

final contactStatisticsNotifierProvider =
    NotifierProvider<ContactStatisticsNotifier, ContactStatisticsState>(
      ContactStatisticsNotifier.new,
    );

final contactSearchNotifierProvider =
    NotifierProvider<ContactsSearchNotifier, ContactsState>(
      ContactsSearchNotifier.new,
    );
