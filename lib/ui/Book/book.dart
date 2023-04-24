import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/wishlist/wishlist_bloc.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';
import 'package:mylibraryapps/data/models/book.dart';
import 'package:mylibraryapps/ui/BookDetail/book_detail.dart';

import '../../bloc/book/book_bloc.dart';
import '../../controller/book_controller.dart';
import 'widgets/book_widgets.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "List Book"),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is GetBooksLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is GetBooksSuccess) {
            if (state.books != null) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: state.books!.length,
                  itemBuilder: (contexts, index) {
                    final book = state.books![index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => BookBloc()
                                  ..emit(GetBookSuccess(
                                    book: state.books![index],
                                  )),
                              ),
                              BlocProvider(
                                create: (context) => WishlistBloc()
                                  ..add(GetWishlistEvent(
                                    bookId: state.books![index].id!,
                                    userId: 4,
                                  )),
                              ),
                            ],
                            child: const DetailBookView(),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 135,
                        width: 357,
                        margin: const EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            FutureBuilder<String?>(
                              future: getImageFirebaseStorage(state.books![index].imgUrl),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 135,
                                    width: 88,
                                    child: Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    ),
                                  );
                                }
                                if (snapshot.data != null) {
                                  return imageFound(snapshot);
                                } else {
                                  return imageNotFound();
                                }
                              },
                            ),
                            const SizedBox(width: 15),
                            infoDetailBook(book),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }

          if (state is GetBooksEmpty) {
            return const Center(
              child: Text("Tidak ada data!"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
