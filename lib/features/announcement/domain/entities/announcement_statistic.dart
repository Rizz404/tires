import 'package:equatable/equatable.dart';

class AnnouncementStatistic extends Equatable {
  final int totalAnnouncements;
  final int active;
  final int inactive;
  final int today;

  AnnouncementStatistic({
    required this.totalAnnouncements,
    required this.active,
    required this.inactive,
    required this.today,
  });

  @override
  List<Object> get props => [totalAnnouncements, active, inactive, today];
}
