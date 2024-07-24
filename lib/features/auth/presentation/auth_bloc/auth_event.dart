part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class SignUpEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  SignUpEvent({required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [context, email, password];
}

class SignInEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  SignInEvent({required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [context, email, password];
}

class CheckAuthEvent extends AuthEvent {
  final BuildContext context;

  CheckAuthEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class LogoutEvent extends AuthEvent {
  LogoutEvent();

  @override
  List<Object?> get props => [];
}
