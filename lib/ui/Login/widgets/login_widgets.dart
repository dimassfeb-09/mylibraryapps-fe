import 'package:flutter/material.dart';

Widget customRememberMe(
    {bool isRememberMe = false, required void Function(bool?)? onChanged}) {
  return Row(
    children: [
      Checkbox(
        activeColor: const Color(0xFF0148BB),
        value: isRememberMe,
        onChanged: onChanged,
      ),
      const Text("Remember Me"),
    ],
  );
}

Widget customForgotPassword({required void Function()? onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      "Forgot password?",
      style: TextStyle(
        fontSize: 12,
        color: Colors.black.withOpacity(0.3),
      ),
    ),
  );
}
