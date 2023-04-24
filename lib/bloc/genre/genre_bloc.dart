import 'package:bloc/bloc.dart';
import 'package:mylibraryapps/controller/genre_controller.dart';
import 'package:mylibraryapps/data/models/genre.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GetGenresEvent>((event, emit) async {
      print("called");
      emit(GetGenresLoadingState());
      await Future.delayed(const Duration(microseconds: 500));
      final genres = await getGenresByCategoryID(categoryId: event.categoryId);
      if (genres != null) {
        emit(GetGenresSuccessState(genres));
        return;
      } else {
        emit(GetGenresSuccessState(null));
      }
    });
  }
}
