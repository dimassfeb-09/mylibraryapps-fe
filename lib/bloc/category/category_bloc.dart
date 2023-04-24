import 'package:bloc/bloc.dart';
import 'package:mylibraryapps/controller/category_controller.dart';

import '../../data/models/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategorysEvent>((event, emit) async {
      emit(GetCategorysLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));

      List<Category>? categories = await getCategories();
      if (categories != null) {
        emit(GetCategorysSuccessState(categories: categories));
        return;
      }
    });
  }
}
