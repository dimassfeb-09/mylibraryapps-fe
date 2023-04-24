part of 'category_bloc.dart';

abstract class CategoryState {
  final List<Category>? categories;
  CategoryState({this.categories});
}

class CategoryInitial extends CategoryState {}

class GetCategorysLoadingState extends CategoryState {}

class GetCategorysSuccessState extends CategoryState {
  final List<Category>? categories;
  GetCategorysSuccessState({this.categories}) : super(categories: categories);
}
