part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class SearchBookEvent extends BookEvent {
  final String query;
  SearchBookEvent({this.query = ""});
}

class GetBooksByIDEvent extends BookEvent {
  final int? categoryId;
  final int? genreId;
  GetBooksByIDEvent({this.categoryId = 0, this.genreId = 0});
}

class GetBooksByBookIDEvent extends BookEvent {
  final int? bookId;
  GetBooksByBookIDEvent({this.bookId = 0});
}
