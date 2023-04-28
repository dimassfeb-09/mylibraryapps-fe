import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/utils/url.dart';
import '../../bloc/register/register_bloc.dart';

import '/common/widgets/toast.dart';

Future<void> registerController(BuildContext context) async {
  RegisterState result = context.read<RegisterBloc>().state;
  try {
    String name = result.name;
    String npm = result.npm;
    String email = result.email;
    String password = result.password;

    if (name == "") {
      return toastInfo(msg: "Name is required");
    } else if (npm == "") {
      return toastInfo(msg: "NPM is required");
    } else if (email == "") {
      return toastInfo(msg: "Email is required");
    } else if (password == "") {
      return toastInfo(msg: "Password is required");
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    CollectionReference colRef = firestore.collection("users");

    // Adding data user to Firestore
    if (credential.user != null) {
      colRef.doc(credential.user!.uid).set({
        "uuid": credential.user!.uid,
        "name": name,
        "npm": npm,
        "email": email,
      })
        ..then((value) async {
          Uri path = Uri.parse("$url/user/add");
          try {
            final response = await http.post(
              path,
              body: json.encode({
                "email": email,
                "password": password,
                "npm": npm,
                "name": name,
                "uuid": credential.user!.uid,
                "is_google": true
              }),
              headers: {"Content-Type": "application/json"},
            );
            if (response.statusCode == 200) {
              Navigator.of(context).pop();
              return toastInfo(msg: "Berhasil daftar, silahkan login.");
            } else {
              throw response.body;
            }
          } catch (e) {
            print(e);
          }
        })
        ..catchError((e) {
          toastInfo(msg: "Failed to register $e");
        });
    }

    //
  } catch (e) {
    return toastInfo(msg: e.toString());
  }
}
