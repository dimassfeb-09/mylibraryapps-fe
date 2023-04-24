part of 'genre_bloc.dart';

abstract class GenreState {
  List<Genre>? genres = [];

  GenreState({this.genres});
}

class GenreInitial extends GenreState {}

class GetGenresState extends GenreState {}

class GetGenresLoadingState extends GenreState {}

class GetGenresSuccessState extends GenreState {
  List<Genre>? genres = [];
  GetGenresSuccessState(this.genres) : super();
}
