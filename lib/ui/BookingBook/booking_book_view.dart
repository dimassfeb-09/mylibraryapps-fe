import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';

class BookingBookView extends StatelessWidget {
  const BookingBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Booking Book"),
      body: const Center(
        child: Text("Booking Book"),
      ),
    );
  }
}
