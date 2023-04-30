part of 'wishlist_bloc.dart';

abstract class WishlistEvent {
  const WishlistEvent();
}

class AddWishlistEvent extends WishlistEvent {
  final int userId;
  final int bookId;
  AddWishlistEvent({this.userId = 0, this.bookId = 0});
}

class GetWishlistEvent extends WishlistEvent {
  final int userId;
  final int bookId;
  final bool isWishlist;
  GetWishlistEvent({this.userId = 0, this.isWishlist = false, this.bookId = 0});
}

class DeleteWishlistEvent extends WishlistEvent {
  final int id;
  DeleteWishlistEvent({this.id = 0});
}

class GetWishlistByUserID extends WishlistEvent {
  final int userId;
  GetWishlistByUserID({this.userId = 0});
}
