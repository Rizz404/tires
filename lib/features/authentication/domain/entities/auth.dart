import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class Auth extends Equatable {
  final User user;
  final String token;

  const Auth({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}
