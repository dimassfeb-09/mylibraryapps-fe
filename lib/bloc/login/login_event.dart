part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EmailEvent extends LoginEvent {
  final String email;
  EmailEvent(this.email);
}

class PasswordEvent extends LoginEvent {
  final String password;
  PasswordEvent(this.password);
}

class IsRememberMeEvent extends LoginEvent {
  final bool isRememberMe;
  IsRememberMeEvent(this.isRememberMe);
}
