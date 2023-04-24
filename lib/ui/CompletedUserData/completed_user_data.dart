import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/register/register_bloc.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';
import 'package:mylibraryapps/common/widgets/button.dart';
import 'package:mylibraryapps/common/widgets/text_field.dart';
import 'package:mylibraryapps/controller/completed_user_data.dart';

class CompletedUserData extends StatelessWidget {
  CompletedUserData({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;
    String email = _auth.currentUser!.email!;
    String name = _auth.currentUser!.displayName!;
    RegisterBloc registerBloc = context.read<RegisterBloc>();

    return Scaffold(
      appBar: customAppBar(title: "Verifikasi Data"),
      body: SingleChildScrollView(
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                customTextField(
                  enabled: false,
                  title: "Full Name",
                  hintText: name,
                ),
                customTextField(
                  title: "NPM",
                  hintText: "Enter your NPM",
                  onChanged: (value) {
                    registerBloc.add(NPMEvent(value));
                  },
                ),
                customTextField(
                  enabled: false,
                  title: "Email",
                  hintText: email,
                ),
                const SizedBox(height: 20),
                customButton(
                  buttonName: "Submit",
                  type: "login",
                  onTap: () async => await completedUserDataController(context, uid, name, state.npm, email),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
