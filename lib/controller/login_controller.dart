import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mylibraryapps/ui/CompletedUserData/completed_user_data.dart';

import '../../bloc/login/login_bloc.dart';
import '../ui/Home/home.dart';
import '/common/widgets/toast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> loginController(BuildContext context, String type) async {
  try {
    // User Log In with email and password
    if (type == "email") {
      final result = context.read<LoginBloc>().state;
      String email = result.email;
      String password = result.password;
      await signInWithEmail(context, email, password);
      return;
    }

    // User Log In with Google.
    if (type == "google") {
      await signInWithGoogle(context);
      return;
    }

    // Catch
  } catch (e) {
    print(e);
    return;
  }
}

Future<void> signInWithEmail(BuildContext context, String email, String password) async {
  try {
    if (email.isEmpty) {
      toastInfo(msg: "Email is required.");
      return;
    } else if (password.isEmpty) {
      toastInfo(msg: "Password is required.");
      return;
    }

    UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);

    if (credential.user != null) {
      if (!credential.user!.emailVerified) {
        await auth.currentUser!.sendEmailVerification();
        return toastInfo(msg: "Akun belum terverifikasi, cek email untuk verifikasi.");
      }

      toastInfo(msg: "Berhasil login.");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => route is Home);
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

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signIn();

    if (await googleSignIn.isSignedIn()) {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        // Check Firetstore if user data is Completed
        bool isUIDUserExists = await checkUIDUserAlreadyExists(uid);
        if (!isUIDUserExists) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => CompletedUserData(),
              ),
              (route) => false);
          return toastInfo(msg: "Harap verifikasi data anda.");
        }

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
        return toastInfo(msg: "Berhasil Login.");
      }
    } else {
      return toastInfo(msg: "Gagal Login.");
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

Future<bool> checkUIDUserAlreadyExists(String uid) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final data = await firestore.collection("users").doc(uid).get();
    if (!data.exists) {
      return false;
    }
    return true;
  } catch (e) {
    return false;
  }
}
