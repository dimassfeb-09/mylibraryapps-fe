import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common/widgets/toast.dart';
import '../ui/Home/home.dart';

Future<void> completedUserDataController(BuildContext context, String uid, String name, String npm, String email) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  if (npm == "") {
    toastInfo(msg: "NPM is required");
    return;
  }

  CollectionReference colRef = _firestore.collection("users");
  colRef.doc(uid).set({
    "uuid": uid,
    "name": name,
    "npm": npm,
    "email": email,
  })
    ..then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
        (route) => false,
      );

      return toastInfo(msg: "Berhasil Verifikasi Data, selamat datang.");
    })
    ..catchError((e) {
      toastInfo(msg: "Failed to register $e");
    });
}
