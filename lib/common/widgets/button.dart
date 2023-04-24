import 'package:flutter/material.dart';

Widget customButton({
  void Function()? onTap,
  required String buttonName,
  required String type,
  double? height = 48,
  double? width = 99,
  double radiusCilcular = 10,
  EdgeInsetsGeometry? margin,
}) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: type == "login" ? Color(0xFF0148BB) : Colors.white,
          borderRadius: BorderRadius.circular(radiusCilcular),
          border: Border.all(
            width: 0,
          ),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: type == "login" ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
