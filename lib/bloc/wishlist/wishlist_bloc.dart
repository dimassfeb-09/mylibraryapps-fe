import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../controller/book_controller.dart';
import '../../data/models/wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<GetWishlistEvent>((event, emit) async {
      emit(GetWishlistLoading());
      Wishlist? wishlist = await getWishlist(bookId: event.bookId, userId: event.userId);
      if (wishlist != null) {
        print("getting data");
        emit(GetWishlistSuccess(isWishlist: true, wishlist: wishlist));
      } else {
        emit(GetWishlistSuccess(isWishlist: false, wishlist: null));
      }
    });

    on<AddWishlistEvent>((event, emit) async {
      emit(AddWishlistLoading());
      bool isSuccessAddWishlist = await addWishlist(userId: event.userId, bookId: event.bookId);
      if (isSuccessAddWishlist) {
        return emit(AddWishlistSuccess(isWishlist: true));
      } else {
        return emit(AddWishlistFailed());
      }
    });

    on<DeleteWishlistEvent>((event, emit) async {
      emit(DeleteWishlistLoading());
      await Future.delayed(const Duration(microseconds: 200));
      bool isSuccessDeleteWishlist = await deleteWishlist(id: event.id);
      if (isSuccessDeleteWishlist) {
        return emit(DeleteWishlistSuccess(isWishlist: false));
      } else {
        return emit(DeleteWishlistFailed());
      }
    });
  }
}
