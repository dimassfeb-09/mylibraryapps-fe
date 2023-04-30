part of 'new_book_bloc.dart';

abstract class NewBookState {
  final List<Book>? books;
  NewBookState({this.books});
}

class NewBookInitial extends NewBookState {}

class GetNewBooksLoading extends NewBookState {}

class GetNewBooksSuccess extends NewBookState {
  final List<Book> books;
  GetNewBooksSuccess({required this.books}) : super(books: books);
}

class GetNewBooksFailed extends NewBookState {}
