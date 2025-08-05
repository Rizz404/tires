import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int total;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final bool hasPrevPage;
  final bool hasNextPage;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrevPage,
    required this.hasNextPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'total_pages': totalPages,
      'has_prev_page': hasPrevPage,
      'has_next_page': hasNextPage,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      total: map['total'] as int,
      perPage: map['per_page'] as int,
      currentPage: map['current_page'] as int,
      totalPages: map['total_pages'] as int,
      hasPrevPage: map['has_prev_page'] as bool,
      hasNextPage: map['has_next_page'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) =>
      Pagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pagination(total: $total, perPage: $perPage, currentPage: $currentPage, totalPages: $totalPages, hasPrevPage: $hasPrevPage, hasNextPage: $hasNextPage)';
  }

  Pagination copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? totalPages,
    bool? hasPrevPage,
    bool? hasNextPage,
  }) {
    return Pagination(
      total: total ?? this.total,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object> get props {
    return [total, perPage, currentPage, totalPages, hasPrevPage, hasNextPage];
  }
}
