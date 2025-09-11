import 'package:equatable/equatable.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/features/announcement/domain/entities/announcement.dart';

enum AnnouncementsStatus { initial, loading, success, error, loadingMore }

class AnnouncementsState extends Equatable {
  final AnnouncementsStatus status;
  final List<Announcement> announcements;
  final Cursor? cursor;
  final String? errorMessage;
  final bool hasNextPage;

  const AnnouncementsState({
    this.status = AnnouncementsStatus.initial,
    this.announcements = const [],
    this.cursor,
    this.errorMessage,
    this.hasNextPage = false,
  });

  AnnouncementsState copyWith({
    AnnouncementsStatus? status,
    List<Announcement>? announcements,
    Cursor? cursor,
    String? errorMessage,
    bool? hasNextPage,
  }) {
    return AnnouncementsState(
      status: status ?? this.status,
      announcements: announcements ?? this.announcements,
      cursor: cursor ?? this.cursor,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  AnnouncementsState copyWithClearError() {
    return AnnouncementsState(
      status: status,
      announcements: announcements,
      cursor: cursor,
      errorMessage: null,
      hasNextPage: hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    announcements,
    cursor,
    errorMessage,
    hasNextPage,
  ];
}
