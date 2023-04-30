import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../controller/book_controller.dart';
import '../../controller/wishlist_cotroller.dart';
import '../../data/models/wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<GetWishlistByUserID>((event, emit) async {
      emit(GetWishlistUserIDLoading());
      await Future.delayed(const Duration(microseconds: 500));

      List<Wishlist>? wishlists;

      if (event.userId != 0) {
        wishlists = await getWishlistByUserID(userId: event.userId);
      }

      if (wishlists != null) {
        return emit(GetWishlistUserIDSuccess(wishlists: wishlists));
      } else {
        return emit(GetWishlistUserIDEmpty());
      }
    });

    on<GetWishlistEvent>((event, emit) async {
      emit(GetWishlistLoading());
      await Future.delayed(const Duration(microseconds: 500));

      Wishlist? wishlist;

      if (event.userId != 0 && event.bookId != 0) {
        wishlist = await getWishlist(bookId: event.bookId, userId: event.userId);
      }

      if (wishlist != null) {
        return emit(GetWishlistSuccess(isWishlist: true, wishlist: wishlist));
      } else {
        return emit(GetWishlistEmpty());
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
