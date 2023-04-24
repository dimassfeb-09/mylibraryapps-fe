import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';

import '/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// BLOC IMPORT
import 'bloc/category/category_bloc.dart';
import 'bloc/genre/genre_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/register/register_bloc.dart';

// UI IMPORT
import 'bloc/wishlist/wishlist_bloc.dart';
import 'ui/forgotPassword/bloc/forgot_password_bloc.dart';
import 'ui/Home/home.dart';
import 'ui/Login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instanceFor(app: app);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => BookBloc()),
        BlocProvider(create: (context) => GenreBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => WishlistBloc()),
      ],
      child: MaterialApp(
        home: auth.currentUser != null ? const Home() : const Login(),
      ),
    );
  }
}
