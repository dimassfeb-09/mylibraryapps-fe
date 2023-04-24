import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mylibraryapps/controller/book_controller.dart';

import '../../controller/home_controller.dart';
import '../../data/models/book.dart';
import '../../data/models/wishlist.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<SearchBookEvent>((event, emit) async {
      List<Book>? books;
      if (event.query != "") {
        books = await getBooksByQuery(query: event.query);
      }
      emit(SearchBookState(query: event.query, books: books));
    });

    on<GetBooksByIDEvent>((event, emit) async {
      emit(GetBooksLoading());
      List<Book>? books = await getBooksByID(genreId: event.genreId, categoryId: event.categoryId);
      await Future.delayed(const Duration(microseconds: 500));
      if (books != null) {
        emit(GetBooksSuccess(books: books));
      } else {
        emit(GetBooksEmpty());
      }
    });
  }
}
