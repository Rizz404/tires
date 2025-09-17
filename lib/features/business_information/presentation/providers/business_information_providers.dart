import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_notifier.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_mutation_state.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_notifier.dart';
import 'package:tires/features/business_information/presentation/providers/business_information_state.dart';
import 'package:tires/features/business_information/presentation/providers/public_business_information_notifier.dart';
import 'package:tires/features/business_information/presentation/providers/public_business_information_state.dart';

final businessInformationGetNotifierProvider =
    NotifierProvider<BusinessInformationNotifier, BusinessInformationState>(
      BusinessInformationNotifier.new,
    );

final publicBusinessInformationGetNotifierProvider =
    NotifierProvider<
      PublicBusinessInformationNotifier,
      PublicBusinessInformationState
    >(PublicBusinessInformationNotifier.new);

final businessInformationMutationNotifierProvider =
    NotifierProvider<
      BusinessInformationMutationNotifier,
      BusinessInformationMutationState
    >(BusinessInformationMutationNotifier.new);
