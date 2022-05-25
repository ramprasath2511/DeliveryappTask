import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deliveryapp/Models/message_model.dart';
import 'package:deliveryapp/Services/userController.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userController = UserController();
  MessageModel? message;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());
      final data =
          await userController.loginController(event.email, event.password);
      await Future.delayed(const Duration(milliseconds: 350));
      if (data != null) {
        emit(FailureAuthState(data));
      } else {
        emit(SuccessAuthState());
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }
}
