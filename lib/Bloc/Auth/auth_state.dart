part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class LoadingAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SuccessAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LogOutAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class FailureAuthState extends AuthState {
  String error;
   FailureAuthState( this.error);

  @override
  List<Object?> get props => [error];
}
