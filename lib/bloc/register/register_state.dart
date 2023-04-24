part of 'register_bloc.dart';

class RegisterState {
  final String name;
  final String npm;
  final String email;
  final String password;

  RegisterState({
    this.name = "",
    this.npm = "",
    this.email = "",
    this.password = "",
  });

  RegisterState copyWith(
      {String? name, String? npm, String? email, String? password}) {
    return RegisterState(
      name: name ?? this.name,
      npm: npm ?? this.npm,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
