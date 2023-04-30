part of 'pagination_bloc.dart';

class PaginationState {
  int index;
  PaginationState({this.index = 0});
}

class PaginationInitial extends PaginationState {}

class ChangePaginationState extends PaginationState {
  int index;
  ChangePaginationState({this.index = 0}) : super(index: index);
}
