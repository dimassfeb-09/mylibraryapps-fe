import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mylibraryapps/bloc/wishlist/wishlist_bloc.dart';
import 'package:mylibraryapps/common/widgets/button.dart';
import 'package:mylibraryapps/common/widgets/toast.dart';
import 'package:mylibraryapps/controller/book_controller.dart';
import 'package:mylibraryapps/data/models/book.dart';
import 'package:mylibraryapps/ui/BookingBook/booking_book_view.dart';

import '/bloc/book/book_bloc.dart';
import '/common/widgets/appbar.dart';

class DetailBookView extends StatelessWidget {
  const DetailBookView({super.key});

  @override
  Widget build(BuildContext context) {
    BookBloc bookBloc = context.read<BookBloc>();
    WishlistBloc wishlistBloc = context.read<WishlistBloc>();

    BookState bookState = bookBloc.state;
    WishlistState wishlistState = wishlistBloc.state;

    if (bookState.book == null) {
      return Scaffold(
        appBar: customAppBar(title: "Detail Book"),
        body: const Center(child: Text("Tidak ada detail data!")),
      );
    }
    return Scaffold(
      appBar: customAppBar(
        title: "Detail Book",
        action: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.favorite),
                color: state.isWishlist ? Colors.red : Colors.grey,
                enableFeedback: true,
                onPressed: () {
                  context.read<WishlistBloc>().add(GetWishlistEvent(bookId: bookState.book!.id!, userId: 4));
                  if (state.isWishlist) {
                    if (state.wishlist != null) {
                      context.read<WishlistBloc>().add(DeleteWishlistEvent(id: state.wishlist!.id!));
                      return;
                    }
                    return;
                  } else {
                    if (bookState.book != null) {
                      context.read<WishlistBloc>().add(AddWishlistEvent(bookId: bookState.book!.id!, userId: 4));
                    }
                    return;
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Center(
                // GETTING IMAGE
                child: FutureBuilder<String?>(
                    future: getImageFirebaseStorage(bookState.book!.imgUrl!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: const EdgeInsets.only(top: 25),
                          height: 365,
                          width: 252,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.only(top: 25),
                        height: 365,
                        width: 252,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: snapshot.data != null
                              ? Image.network(snapshot.data!, fit: BoxFit.cover)
                              : const Center(
                                  child: Text(
                                    "Image Not Found",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10),
              Text(
                bookState.book!.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: bookState.book!.rating!.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
                ignoreGestures: true,
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 370,
                      height: 120,
                      child: Text(
                        bookState.book!.description!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Writer",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bookState.book!.writer!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 91,
                      decoration: BoxDecoration(
                        color: bookState.book!.stok! > 0 ? Color(0XFF00FF84) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(bookState.book!.stok! > 0 ? "Tersedia" : "Kosong"),
                    ),
                    const SizedBox(height: 10),
                    Text("Stok tersedia: ${bookState.book!.stok!}"),
                  ],
                ),
              ),
              Center(
                child: customButton(
                  buttonName: "Add Booking",
                  type: "login",
                  height: 41,
                  width: 158,
                  radiusCilcular: 20,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingBookView(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
