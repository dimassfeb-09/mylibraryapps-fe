import 'package:flutter/material.dart';

Widget customTextField({
  required String title,
  required String hintText,
  bool? enabled,
  String? type,
  void Function(String value)? onChanged,
}) {
  return Center(
    child: Container(
      height: 73,
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(title),
          ),
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 46,
            width: 320,
            child: TextField(
              enabled: enabled,
              autocorrect: false,
              onChanged: onChanged,
              keyboardType: type == "email" ? TextInputType.emailAddress : TextInputType.text,
              textInputAction: type != "password" ? TextInputAction.next : TextInputAction.done,
              obscureText: type == "password" ?? true,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: type != null ? Image.asset("assets/images/$type.png") : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
