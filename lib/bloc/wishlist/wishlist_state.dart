part of 'wishlist_bloc.dart';

abstract class WishlistState {
  final bool isWishlist;
  final Wishlist? wishlist;
  final List<Wishlist>? wishlists;

  WishlistState({this.isWishlist = false, this.wishlist, this.wishlists});
}

class WishlistInitial extends WishlistState {}

// ADD WISHLIST
class AddWishlistLoading extends WishlistState {}

class AddWishlistSuccess extends WishlistState {
  final bool isWishlist;
  AddWishlistSuccess({this.isWishlist = false}) : super(isWishlist: isWishlist);
}

class AddWishlistFailed extends WishlistState {}

// GET WISHLIST BY USER AND BOOK ID
class GetWishlistLoading extends WishlistState {}

class GetWishlistEmpty extends WishlistState {}

class GetWishlistSuccess extends WishlistState {
  final bool isWishlist;
  final Wishlist? wishlist;
  GetWishlistSuccess({this.isWishlist = false, this.wishlist}) : super(isWishlist: isWishlist, wishlist: wishlist);
}

class GetWishlistUserIDLoading extends WishlistState {}

class GetWishlistUserIDEmpty extends WishlistState {}

class GetWishlistUserIDSuccess extends WishlistState {
  final List<Wishlist>? wishlists;
  GetWishlistUserIDSuccess({this.wishlists}) : super(wishlists: wishlists);
}

// DELETE WISHLIST
class DeleteWishlistLoading extends WishlistState {}

class DeleteWishlistSuccess extends WishlistState {
  final bool isWishlist;
  DeleteWishlistSuccess({this.isWishlist = false}) : super(isWishlist: isWishlist);
}

class DeleteWishlistFailed extends WishlistState {}
