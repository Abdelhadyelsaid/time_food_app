part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class GoogleFirebaseLoadingState extends AuthState {}

final class GoogleFirebaseSuccessState extends AuthState {}

final class GoogleFirebaseErrorState extends AuthState {
  final String message;

  GoogleFirebaseErrorState(this.message);
}

class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState(this.message);
}

final class LoginSuccessState extends AuthState {}

final class LoginLoadingState extends AuthState {}

///Show Password
final class ChangeShowPasswordState extends AuthState {}

///Show Confirm Password
final class ChangeShowConfirmPasswordState extends AuthState {}

///Sign Up
class SignUpLoadingState extends AuthState {}

class SignUpErrorState extends AuthState {
  String message;

  SignUpErrorState(this.message);
}

class SignUpSuccessState extends AuthState {}

/// Forget password
class SendForgetPasswordRequestLoadingState extends AuthState {}

class SendForgetPasswordRequestErrorState extends AuthState {}

class SendForgetPasswordRequestSuccessState extends AuthState {}

class ReSendForgetPasswordRequestLoadingState extends AuthState {}

class ReSendForgetPasswordRequestErrorState extends AuthState {}

class ReSendForgetPasswordRequestSuccessState extends AuthState {}


class TimerStopState extends AuthState {}

class TimerStartState extends AuthState {}

class TimerMinusState extends AuthState {}
