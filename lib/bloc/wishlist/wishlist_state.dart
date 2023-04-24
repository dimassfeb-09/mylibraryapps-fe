part of 'wishlist_bloc.dart';

abstract class WishlistState {
  final bool isWishlist;
  final Wishlist? wishlist;

  WishlistState({
    this.isWishlist = false,
    this.wishlist,
  });
}

class WishlistInitial extends WishlistState {}

// ADD WISHLIST
class AddWishlistLoading extends WishlistState {}

class AddWishlistSuccess extends WishlistState {
  final bool isWishlist;
  AddWishlistSuccess({this.isWishlist = false}) : super(isWishlist: isWishlist);
}

class AddWishlistFailed extends WishlistState {}

// GET WISHLIST
class GetWishlistLoading extends WishlistState {}

class GetWishlistSuccess extends WishlistState {
  final bool isWishlist;
  final Wishlist? wishlist;
  GetWishlistSuccess({this.isWishlist = false, this.wishlist})
      : super(
          isWishlist: isWishlist,
          wishlist: wishlist,
        );
}

// DELETE WISHLIST

class DeleteWishlistLoading extends WishlistState {}

class DeleteWishlistSuccess extends WishlistState {
  final bool isWishlist;
  DeleteWishlistSuccess({this.isWishlist = false}) : super(isWishlist: isWishlist);
}

class DeleteWishlistFailed extends WishlistState {}
