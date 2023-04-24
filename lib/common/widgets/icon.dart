import 'package:flutter/cupertino.dart';

Widget customIconImage({required String type}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    alignment: Alignment.center,
    child: Image.asset("assets/images/$type.png", height: 33, width: 32),
  );
}
