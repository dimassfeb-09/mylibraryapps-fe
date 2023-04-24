part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class EmailEvent extends ForgotPasswordEvent {
  final String email;
  EmailEvent(this.email);
}
