import 'package:flutter/material.dart';

AppBar customAppBar(
    {required String title, Color color = Colors.white, List<Widget>? action}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    actions: action,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(2),
      child: Container(
        height: 1,
        color: Colors.black.withOpacity(0.5),
      ),
    ),
    backgroundColor: color,
  );
}
