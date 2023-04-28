import 'package:flutter/material.dart';

Widget customSearchTextField({
  EdgeInsetsGeometry? margin,
  void Function(String value)? onSubmit,
  void Function(String value)? onChanged,
  void Function()? onCancel,
  bool visibleCancel = false,
  TextEditingController? controller,
}) {
  return Container(
    margin: margin,
    height: 46,
    width: 320,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFAFBACA)),
    ),
    child: TextField(
      controller: controller,
      autocorrect: false,
      onSubmitted: onSubmit,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.filter_list, size: 20, color: Colors.grey),
        suffixIcon: Visibility(
          visible: visibleCancel,
          child: GestureDetector(
            onTap: onCancel,
            child: Icon(Icons.cancel, size: 20, color: Colors.grey),
          ),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      ),
    ),
  );
}
