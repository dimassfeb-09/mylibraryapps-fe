import 'package:flutter/material.dart';

Widget customRegisterOrLogin(
    {required void Function()? onNavigateTo, required String type}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 15),
      Text(type == "login"
          ? "Don't have an account yet?"
          : "Already have an account?"),
      TextButton(
        onPressed: onNavigateTo,
        child: Text("${type == "login" ? "Register" : "Login"} here"),
      ),
    ],
  );
}
