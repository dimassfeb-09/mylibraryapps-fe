part of 'book_bloc.dart';

@immutable
abstract class BookState {
  final int ID;
  final String query;
  final List<Book>? books;
  final Book? book;

  BookState({
    this.ID = 0,
    this.query = "",
    this.books,
    this.book,
  });
}

class BookInitial extends BookState {}

class SearchBookState extends BookState {
  final String query;
  final List<Book>? books;
  SearchBookState({this.query = "", this.books}) : super(query: query, books: books);
}

class GetBooksLoading extends BookState {}

class GetBooksSuccess extends BookState {
  final int id;
  final List<Book>? books;
  GetBooksSuccess({this.id = 0, this.books}) : super(ID: id, books: books);
}

class GetBooksEmpty extends BookState {}

class GetBookSuccess extends BookState {
  final int id;
  final Book? book;
  GetBookSuccess({this.id = 0, this.book}) : super(ID: id, book: book);
}

class GetBookBookIDSuccess extends BookState {
  final Book? book;
  GetBookBookIDSuccess({this.book}) : super(book: book);
}
