import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';
import 'package:mylibraryapps/common/widgets/button.dart';
import 'package:mylibraryapps/common/widgets/text_field.dart';
import 'package:mylibraryapps/controller/forgot_password_controller.dart';

import 'bloc/forgot_password_bloc.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Forgot Password"),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            customTextField(
              title: "Email",
              hintText: "Enter your email",
              onChanged: (value) => context.read<ForgotPasswordBloc>().add(EmailEvent(value)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: customButton(
                buttonName: "Submit",
                type: "login",
                onTap: () => forgotPasswordController(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
