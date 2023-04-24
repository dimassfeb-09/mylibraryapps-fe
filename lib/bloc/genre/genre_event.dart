part of 'genre_bloc.dart';

abstract class GenreEvent {
  const GenreEvent();
}

class GetGenresEvent extends GenreEvent {
  final int genreId;
  final int categoryId;

  GetGenresEvent({this.genreId = 0, this.categoryId = 0});
}
