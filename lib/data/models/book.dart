class Book {
  int? id;
  String? title;
  String? description;
  int? stok;
  String? writer;
  String? imgUrl;
  double? rating;
  int? categoryId;
  int? genreId;

  Book({this.id, this.title, this.description, this.stok, this.writer, this.imgUrl, this.rating, this.categoryId, this.genreId});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    stok = json['stok'];
    writer = json['writer'];
    imgUrl = json['img_url'];
    rating = json['rating'].toDouble();
    categoryId = json['category_id'];
    genreId = json['genre_id'];
  }
}
