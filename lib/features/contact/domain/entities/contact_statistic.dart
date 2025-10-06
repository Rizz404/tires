// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ContactStatistic extends Equatable {
  final Statistics statistics;

  ContactStatistic({required this.statistics});

  @override
  List<Object> get props => [statistics];
}

class Statistics extends Equatable {
  final num total;
  final num pending;
  final num replied;
  final num today;

  Statistics({
    required this.total,
    required this.pending,
    required this.replied,
    required this.today,
  });

  @override
  List<Object> get props => [total, pending, replied, today];
}
