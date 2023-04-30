import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/Pagination/pagination_bloc.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';
import 'package:mylibraryapps/common/widgets/search_textfield.dart';
import 'package:mylibraryapps/ui/Home/widgets/home_widgets.dart';
import 'package:mylibraryapps/ui/Wishlist/wishlist_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/NewBook/new_book_bloc.dart';
import '../../common/widgets/appbar.dart';
import '../../controller/home_controller.dart';

import 'package:bloc/bloc.dart';

import '../BookingBook/booking_book_view.dart';
import '../History/history_view.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc, PaginationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(
            title: pages.elementAt(state.index)["title"],
            action: [logoutButton(context)],
          ),
          body: pages.elementAt(state.index)["screen"],
          bottomNavigationBar: customBottomNavigationBar(state, context),
        );
      },
    );
  }
}

List<Map<String, dynamic>> pages = [
  {"title": "Home", "screen": const HomePage()},
  {"title": "Wishlist", "screen": WishlistView()},
  {"title": "Booking Book", "screen": const BookingBookView()},
  {"title": "History", "screen": const HistoryView()},
];

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 330,
                          left: 21,
                          right: 21,
                        ),
                        height: 204,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Recommendations",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 167,
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(right: 22),
                                  height: 167,
                                  width: 121,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Helo"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 35,
                          left: 21,
                          right: 21,
                        ),
                        height: 204,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "What's new?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 167,
                              child: BlocBuilder<NewBookBloc, NewBookState>(
                                builder: (context, state) {
                                  if (state is GetNewBooksLoading) {
                                    return ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => Container(
                                        margin: const EdgeInsets.only(right: 22),
                                        height: 167,
                                        width: 121,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Center(child: CircularProgressIndicator.adaptive()),
                                      ),
                                    );
                                  }

                                  if (state is GetNewBooksSuccess) {
                                    return ListView.builder(
                                      itemCount: state.books.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => Container(
                                        margin: const EdgeInsets.only(right: 22),
                                        height: 167,
                                        width: 121,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(state.books[index].title!),
                                      ),
                                    );
                                  }

                                  return Container();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 35,
                          left: 21,
                          right: 21,
                        ),
                        height: 204,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Most Read",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 167,
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(right: 22),
                                  height: 167,
                                  width: 121,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Helo"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35, left: 21, right: 21, bottom: 20),
                        height: 204,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Restock Book",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 167,
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(right: 22),
                                  height: 167,
                                  width: 121,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Helo"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  customDropDownListBook(context),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
