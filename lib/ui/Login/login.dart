import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../common/widgets/login_or_register.dart';
import '../../controller/login_controller.dart';
import '../forgotPassword/forgot_password.dart';
import '../register/register.dart';
import '/common/widgets/button.dart';
import '/common/widgets/divider_with.dart';
import '/common/widgets/icon.dart';

import '../../common/widgets/text_field.dart';
import 'widgets/login_widgets.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, left: 54),
                    height: 96,
                    width: 219,
                    child: const Text(
                      "My Library Apps",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 89),
                    height: 158,
                    width: 233,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/book_login.png",
                      ),
                    )),
                  ),
                  customTextField(
                    title: "Email",
                    type: "email",
                    hintText: "Enter your email",
                    onChanged: (value) {
                      context.read<LoginBloc>().add(EmailEvent(value));
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextField(
                        title: "Password",
                        type: "password",
                        hintText: "Enter your password",
                        onChanged: (value) {
                          context.read<LoginBloc>().add(PasswordEvent(value));
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: customForgotPassword(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      ),
                    ),
                  ),
                  customButton(
                    margin: const EdgeInsets.only(top: 10),
                    buttonName: "Login",
                    type: "login",
                    onTap: () => loginController(context, "email"),
                  ),
                  customRegisterOrLogin(
                    type: "login",
                    onNavigateTo: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ),
                    ),
                  ),
                  customDividerWith(type: "login"),
                  GestureDetector(
                    onTap: () => loginController(context, "google"),
                    child: customIconImage(type: "google"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
