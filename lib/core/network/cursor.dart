import 'dart:convert';

import 'package:equatable/equatable.dart';

class Cursor extends Equatable {
  final String nextCursor;
  final bool hasNextPage;
  final int perPage;

  Cursor({
    required this.nextCursor,
    required this.hasNextPage,
    required this.perPage,
  });

  Cursor copyWith({String? nextCursor, bool? hasNextPage, int? perPage}) {
    return Cursor(
      nextCursor: nextCursor ?? this.nextCursor,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'next_cursor': nextCursor,
      'has_next_page': hasNextPage,
      'per_page': perPage,
    };
  }

  factory Cursor.fromMap(Map<String, dynamic> map) {
    return Cursor(
      nextCursor: map['next_cursor'] as String,
      hasNextPage: map['has_next_page'] as bool,
      perPage: map['perPage'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cursor.fromJson(String source) =>
      Cursor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Cursor(nextCursor: $nextCursor, hasNextPage: $hasNextPage, perPage: $perPage)';

  @override
  List<Object> get props => [nextCursor, hasNextPage, perPage];
}
