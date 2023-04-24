import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

toastInfo({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
  );
}
