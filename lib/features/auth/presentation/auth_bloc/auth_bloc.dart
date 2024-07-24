import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:milestory_web/features/auth/domain/usecases/sign_up.dart';
import 'package:milestory_web/core/exception/exceptions.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/check_auth.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<SignUpEvent>(_signUpEventToState);
    on<SignInEvent>(_signInEventToState);
    on<CheckAuthEvent>(_checkAuthToState);
    on<LogoutEvent>(_logoutToState);
  }

  void _signUpEventToState(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await SignUp(_authRepository).call(email: event.email, password: event.password);
      if (response is DataSuccess) {
      } else {
        print(response.error);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInEventToState(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await SignIn(_authRepository).call(email: event.email, password: event.password);
      if (response is DataSuccess) {
        if (response.data!.verify == true) {
          emit(AuthState.authenticated(response.data!));
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  void _checkAuthToState(CheckAuthEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await CheckAuth(_authRepository).call();
      if (response is DataSuccess) {
        if (response.data!.verify == true) {
          emit(AuthState.authenticated(response.data!));
        }
      } else {
        print(response.error);
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _logoutToState(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await Logout(_authRepository).call();
      if (response is DataSuccess) {
        emit(const AuthState.unauthenticated());
      } else {
        print(response.error);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
