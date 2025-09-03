import 'package:equatable/equatable.dart';

class AvailableHour extends Equatable {
  final List<Hour> hours;

  const AvailableHour({required this.hours});

  @override
  List<Object> get props => [hours];
}

class Hour extends Equatable {
  final String time;
  final DateTime datetime;
  final Status status;
  final bool available;
  final Indicator indicator;

  const Hour({
    required this.time,
    required this.datetime,
    required this.status,
    required this.available,
    required this.indicator,
  });

  @override
  List<Object> get props => [time, datetime, status, available, indicator];
}

// ignore: constant_identifier_names
enum Indicator { Empty, Reserved }

enum Status { available, reserved }
