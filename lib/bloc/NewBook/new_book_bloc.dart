import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibraryapps/bloc/book/book_bloc.dart';
import 'package:mylibraryapps/controller/book_controller.dart';

import '../../data/models/book.dart';

part 'new_book_event.dart';
part 'new_book_state.dart';

class NewBookBloc extends Bloc<NewBookEvent, NewBookState> {
  NewBookBloc() : super(NewBookInitial()) {
    on<GetNewBooksEvent>((event, emit) async {
      emit(GetNewBooksLoading());
      await Future.delayed(const Duration(microseconds: 500));
      final books = await getNewBooks();
      if (books != null) {
        emit(GetNewBooksSuccess(books: books));
        return;
      } else {
        emit(GetNewBooksFailed());
        return;
      }
    });
  }
}
