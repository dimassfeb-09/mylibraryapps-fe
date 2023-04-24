class Wishlist {
  int? id;
  int? bookId;
  int? userId;

  Wishlist({this.id, this.bookId, this.userId});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['book_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_id'] = this.bookId;
    data['user_id'] = this.userId;
    return data;
  }
}
