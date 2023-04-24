import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/register/register_bloc.dart';
import '../../common/widgets/login_or_register.dart';
import '../../controller/register_controller.dart';
import '../Login/login.dart';

import '../../common/widgets/appbar.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/divider_with.dart';
import '../../common/widgets/icon.dart';
import '../../common/widgets/text_field.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(title: "Register"),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  customTextField(
                    title: "Name",
                    hintText: "Enter your Name",
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(NameEvent(value));
                    },
                  ),
                  customTextField(
                    title: "NPM",
                    hintText: "Enter your NPM",
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(NPMEvent(value));
                    },
                  ),
                  customTextField(
                    title: "Email",
                    type: "email",
                    hintText: "Enter your email",
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(EmailEvent(value));
                    },
                  ),
                  customTextField(
                    title: "Password",
                    type: "password",
                    hintText: "Enter your password",
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(PasswordEvent(value));
                    },
                  ),
                  customButton(
                    margin: const EdgeInsets.only(top: 25),
                    buttonName: "Register",
                    type: "login",
                    onTap: () => registerController(context),
                  ),
                  customRegisterOrLogin(
                    type: "register",
                    onNavigateTo: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    ),
                  ),
                  customDividerWith(type: "register"),
                  customIconImage(type: "google")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
