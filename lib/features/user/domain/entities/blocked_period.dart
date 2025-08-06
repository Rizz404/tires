import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';

class BlockedPeriod extends Equatable {
  final int id;
  final Menu? menu;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String reason;
  final bool allMenus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BlockedPeriod({
    required this.id,
    this.menu,
    required this.startDatetime,
    required this.endDatetime,
    required this.reason,
    required this.allMenus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    menu,
    startDatetime,
    endDatetime,
    reason,
    allMenus,
    createdAt,
    updatedAt,
  ];
}
