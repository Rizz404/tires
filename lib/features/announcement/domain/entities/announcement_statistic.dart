import 'package:equatable/equatable.dart';

class AnnouncementStatistic extends Equatable {
  final num totalAnnouncements;
  final num active;
  final num inactive;
  final num today;

  AnnouncementStatistic({
    required this.totalAnnouncements,
    required this.active,
    required this.inactive,
    required this.today,
  });

  @override
  List<Object> get props => [totalAnnouncements, active, inactive, today];
}
