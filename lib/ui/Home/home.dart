import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';
import 'package:mylibraryapps/common/widgets/search_textfield.dart';
import 'package:mylibraryapps/ui/Home/widgets/home_widgets.dart';

import '../../common/widgets/appbar.dart';
import '../../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Home",
        action: [
          GestureDetector(
            onTap: () => singOutController(context),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(Icons.logout, size: 30),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                BookBloc book = context.read<BookBloc>();
                return Stack(
                  children: [
                    customHomeBanner(),
                    customSearchTextField(
                      margin: const EdgeInsets.only(top: 24, left: 55, right: 55),
                      controller: TextEditingController(text: state.query),
                      onSubmit: (value) => book.add(SearchBookEvent(query: value)),
                      onCancel: () => book.add(SearchBookEvent(query: "")),
                      visibleCancel: state.query != "" ? true : false,
                    ),
                    menuCategory(context),
                    customDropDownListBook(context),
                  ],
                );
              },
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), label: "Booking Book"),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: "History"),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF003790),
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}
