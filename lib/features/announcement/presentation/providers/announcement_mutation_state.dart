import 'package:equatable/equatable.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/user/domain/entities/announcement.dart';

enum AnnouncementMutationStatus { initial, loading, success, error }

class AnnouncementMutationState extends Equatable {
  final AnnouncementMutationStatus status;
  final Announcement? updatedAnnouncement;
  final Failure? failure;
  final String? successMessage;

  const AnnouncementMutationState({
    this.status = AnnouncementMutationStatus.initial,
    this.updatedAnnouncement,
    this.failure,
    this.successMessage,
  });

  AnnouncementMutationState copyWith({
    AnnouncementMutationStatus? status,
    Announcement? updatedAnnouncement,
    Failure? failure,
    String? successMessage,
  }) {
    return AnnouncementMutationState(
      status: status ?? this.status,
      updatedAnnouncement: updatedAnnouncement ?? this.updatedAnnouncement,
      failure: failure ?? this.failure,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  AnnouncementMutationState copyWithClearError() {
    return AnnouncementMutationState(
      status: status,
      updatedAnnouncement: updatedAnnouncement,
      failure: null,
      successMessage: successMessage,
    );
  }

  AnnouncementMutationState copyWithClearSuccess() {
    return AnnouncementMutationState(
      status: status,
      updatedAnnouncement: updatedAnnouncement,
      failure: failure,
      successMessage: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    updatedAnnouncement,
    failure,
    successMessage,
  ];
}
