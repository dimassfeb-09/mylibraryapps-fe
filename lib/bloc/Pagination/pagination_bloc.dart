import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc() : super(PaginationInitial()) {
    on<ChangePagination>((event, emit) {
      emit(PaginationState(index: event.index));
    });
  }
}
