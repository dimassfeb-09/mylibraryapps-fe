part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  final bool isRememberMe;

  LoginState({this.email = "", this.password = "", this.isRememberMe = false});

  LoginState copyWith({String? email, String? password, bool? isRememberMe}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class IsRememberMeState extends LoginState {
  final bool isRememberMe;
  IsRememberMeState(this.isRememberMe) : super(isRememberMe: isRememberMe);
}
