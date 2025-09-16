import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/features/availability/domain/usecases/get_availability_calendar_usecase.dart';
import 'package:tires/features/availability/presentation/providers/availability_notifier.dart';
import 'package:tires/features/availability/presentation/providers/availability_state.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';
import 'package:tires/di/repository_providers.dart';

final getAvailabilityCalendarUsecaseProvider =
    Provider<GetAvailabilityCalendarUsecase>((ref) {
      final availabilityRepository = ref.watch(availabilityRepoProvider);
      return GetAvailabilityCalendarUsecase(availabilityRepository);
    });

final availabilityNotifierProvider =
    NotifierProvider<AvailabilityNotifier, AvailabilityState>(
      AvailabilityNotifier.new,
    );
