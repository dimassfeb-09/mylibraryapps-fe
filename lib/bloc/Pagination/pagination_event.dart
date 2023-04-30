part of 'pagination_bloc.dart';

abstract class PaginationEvent {
  int index;
  PaginationEvent({this.index = 0});
}

class ChangePagination extends PaginationEvent {
  int index;
  ChangePagination({required this.index}) : super(index: index);

  ChangePagination copyWith(int index) {
    return ChangePagination(index: index);
  }
}
