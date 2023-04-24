import 'package:flutter/material.dart';

Widget customDividerWith({required String type}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const SizedBox(
        width: 100,
        child: Divider(
          thickness: 1,
        ),
      ),
      Text(
        "Or ${type == "login" ? "Login" : "Register"} with",
        style: TextStyle(
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      const SizedBox(
        width: 100,
        child: Divider(
          thickness: 1,
        ),
      ),
    ],
  );
}
