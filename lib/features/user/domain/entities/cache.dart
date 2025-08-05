import 'package:equatable/equatable.dart';

class Cache extends Equatable {
  final String key;
  final String value;
  final int expiration;

  Cache({required this.key, required this.value, required this.expiration});

  @override
  List<Object> get props => [key, value, expiration];
}

class CacheLock extends Equatable {
  final String key;
  final String owner;
  final int expiration;

  CacheLock({required this.key, required this.owner, required this.expiration});

  @override
  List<Object> get props => [key, owner, expiration];
}
