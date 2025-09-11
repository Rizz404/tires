import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int id;
  final String queue;
  final String payload;
  final int attempts;
  final int? reservedAt;
  final int availableAt;
  final int createdAt;

  const Job({
    required this.id,
    required this.queue,
    required this.payload,
    required this.attempts,
    this.reservedAt,
    required this.availableAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    queue,
    payload,
    attempts,
    reservedAt,
    availableAt,
    createdAt,
  ];
}

class JobBatch extends Equatable {
  final int id;
  final String name;
  final int totalJobs;
  final int pendingJobs;
  final int failedJobs;
  final String failedJobIds;
  final String? options;
  final int? cancelledAt;
  final int createdAt;
  final int? finishedAt;

  const JobBatch({
    required this.id,
    required this.name,
    required this.totalJobs,
    required this.pendingJobs,
    required this.failedJobs,
    required this.failedJobIds,
    this.options,
    this.cancelledAt,
    required this.createdAt,
    this.finishedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    totalJobs,
    pendingJobs,
    failedJobs,
    failedJobIds,
    options,
    cancelledAt,
    createdAt,
    finishedAt,
  ];
}

class FailedJob extends Equatable {
  final int id;
  final String uuid;
  final String connection;
  final String queue;
  final String payload;
  final String exception;
  final DateTime failedAt;

  const FailedJob({
    required this.id,
    required this.uuid,
    required this.connection,
    required this.queue,
    required this.payload,
    required this.exception,
    required this.failedAt,
  });

  @override
  List<Object?> get props => [
    id,
    uuid,
    connection,
    queue,
    payload,
    exception,
    failedAt,
  ];
}
