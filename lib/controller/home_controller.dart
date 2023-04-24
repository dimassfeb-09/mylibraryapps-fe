import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../data/models/book.dart';
import '/common/widgets/toast.dart';
import '/utils/url.dart';

import '../ui/Login/login.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> singOutController(BuildContext context) async {
  try {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    } else if (_auth.currentUser != null) {
      await _auth.signOut();
    }

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (route) => false);

    return toastInfo(msg: "Berhasil Logout");
  } catch (e) {
    print(e);
    return;
  }
}

Future<List<Book>?> getBooksByQuery({required String query}) async {
  try {
    Uri path = Uri.parse("$url/book/get?title=$query");
    final response = await http.get(path);

    List? book = json.decode(response.body)["data"];

    List<Book>? books = [];
    if (book != null) {
      book.forEach((e) {
        books!.add(Book.fromJson(e));
      });
      print(books);
      return books;
    } else {
      books = null;
    }
  } catch (e) {
    return null;
  }
}
