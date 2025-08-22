import 'dart:convert';
import 'package:equatable/equatable.dart';

class Cursor extends Equatable {
  final String? nextCursor;
  final String? previousCursor;
  final bool hasNextPage;
  final int perPage;

  const Cursor({
    this.nextCursor,
    this.previousCursor,
    required this.hasNextPage,
    required this.perPage,
  });

  Cursor copyWith({
    String? nextCursor,
    String? previousCursor,
    bool? hasNextPage,
    int? perPage,
  }) {
    return Cursor(
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.previousCursor,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'next_cursor': nextCursor,
      'previous_cursor': previousCursor,
      'has_next_page': hasNextPage,
      'per_page': perPage,
    };
  }

  factory Cursor.fromMap(Map<String, dynamic> map) {
    return Cursor(
      nextCursor: map['next_cursor'] as String?,
      previousCursor: map['previous_cursor'] as String?,
      hasNextPage: map['has_next_page'] as bool,
      perPage: map['per_page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cursor.fromJson(String source) => Cursor.fromMap(json.decode(source));

  @override
  String toString() =>
      'Cursor(nextCursor: $nextCursor, previousCursor: $previousCursor, hasNextPage: $hasNextPage, perPage: $perPage)';

  @override
  List<Object?> get props => [nextCursor, previousCursor, hasNextPage, perPage];
}
