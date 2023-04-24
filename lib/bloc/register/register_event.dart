part of 'register_bloc.dart';

abstract class RegisterEvent {}

class NameEvent extends RegisterEvent {
  final String name;
  NameEvent(this.name);
}

class NPMEvent extends RegisterEvent {
  final String npm;
  NPMEvent(this.npm);
}

class EmailEvent extends RegisterEvent {
  final String email;
  EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent {
  final String password;
  PasswordEvent(this.password);
}
