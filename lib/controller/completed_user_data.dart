import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylibraryapps/controller/login_controller.dart';

import '../common/widgets/toast.dart';
import '../ui/Home/home.dart';
import '../utils/url.dart';

Future<void> completedUserDataController(BuildContext context, String uid, String name, String npm, String email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  if (npm == "") {
    toastInfo(msg: "NPM is required");
    return;
  }

  Uri path = Uri.parse("$url/user/add");
  final response = await http.post(
    path,
    body: json.encode({
      "email": email,
      "password": "withGoogle",
      "npm": npm,
      "name": name,
      "uuid": auth.currentUser!.uid,
      "is_google": true,
    }),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    CollectionReference colRef = _firestore.collection("users");
    colRef.doc(uid).set({
      "uuid": uid,
      "name": name,
      "npm": npm,
      "email": email,
    })
      ..then((value) async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
          (route) => false,
        );

        return toastInfo(msg: "Berhasil Verifikasi Data, selamat datang.");
      })
      ..catchError((e) {
        toastInfo(msg: "Failed to register $e");
      });

    return;
  } else {
    return toastInfo(msg: json.decode(response.body.toString())["msg"]);
  }
}
