import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum TireStorageStatus { active, ended }

class TireStorage extends Equatable {
  final int id;
  final User user;
  final String tireBrand;
  final String tireSize;
  final DateTime storageStartDate;
  final DateTime plannedEndDate;
  final double? storageFee;
  final TireStorageStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TireStorage({
    required this.id,
    required this.user,
    required this.tireBrand,
    required this.tireSize,
    required this.storageStartDate,
    required this.plannedEndDate,
    this.storageFee,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    tireBrand,
    tireSize,
    storageStartDate,
    plannedEndDate,
    storageFee,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
}
