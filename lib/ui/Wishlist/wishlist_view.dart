import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';
import 'package:mylibraryapps/common/widgets/appbar.dart';
import 'package:mylibraryapps/controller/book_controller.dart';
import 'package:mylibraryapps/ui/Book/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/wishlist/wishlist_bloc.dart';
import '../BookDetail/book_detail.dart';

class WishlistView extends StatelessWidget {
  WishlistView({super.key});

  int userId = 0;

  void getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("user_id");

    this.userId = userId != null ? userId : 0;
  }

  @override
  Widget build(BuildContext context) {
    getUserId();

    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: WishlistBloc()..add(GetWishlistByUserID(userId: userId)),
      builder: (context, state) {
        if (state is GetWishlistUserIDLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state is GetWishlistUserIDSuccess) {
          return ListView.builder(
            itemCount: state.wishlists?.length,
            itemBuilder: (context, index) {
              return BlocBuilder<BookBloc, BookState>(
                bloc: BookBloc()..add(GetBooksByBookIDEvent(bookId: state.wishlists![index].bookId)),
                builder: (context, state) {
                  if (state is GetBookBookIDSuccess) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => BookBloc()..emit(GetBookSuccess(book: state.book)),
                            ),
                            BlocProvider(
                              create: (context) => WishlistBloc()..add(GetWishlistEvent(bookId: state.book!.id!, userId: 4)),
                            ),
                          ],
                          child: const DetailBookView(),
                        );
                      })),
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.book!.title!),
                            const Icon(Icons.favorite, color: Colors.red),
                          ],
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              );
            },
          );
        }

        if (state is GetWishlistEmpty) {
          return const Center(child: Text("Tidak ada data!"));
        }

        return Container();
      },
    );
  }
}
