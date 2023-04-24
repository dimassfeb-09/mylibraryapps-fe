import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/common/widgets/toast.dart';
import 'package:mylibraryapps/ui/forgotPassword/bloc/forgot_password_bloc.dart';

Future<void> forgotPasswordController(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  ForgotPasswordBloc forgotPasswordBloc = context.read<ForgotPasswordBloc>();
  String email = forgotPasswordBloc.state.email;

  try {
    if (email != "") {
      await auth.sendPasswordResetEmail(email: email);
      toastInfo(msg: "Silahkan cek email untuk mengubah password.");
      Navigator.pop(context);
      return;
    } else {
      toastInfo(msg: "Email is required");
      return;
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "invalid-email":
        toastInfo(msg: "Format email tidak diizinkan.");
        return;
      case "user-not-found":
        toastInfo(msg: "Akun tidak ditemukan, silahkan mendaftar terlebih dahulu.");
        return;
      case "too-many-requests":
        toastInfo(msg: "Terlalu banyak permintaan, silahkan tunggu beberapa saat lagi.");
        return;
      default:
        toastInfo(msg: "Mohon maaf, terjadi kesalahan.");
        return;
    }
  }
}
