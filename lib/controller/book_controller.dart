import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mylibraryapps/data/models/book.dart';
import 'package:mylibraryapps/data/models/wishlist.dart';
import 'package:mylibraryapps/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/category.dart';

List<Category> categories = [
  Category(id: 1, name: "Math"),
  Category(id: 2, name: "Science"),
  Category(id: 3, name: "Art"),
  Category(id: 4, name: "Technology"),
  Category(id: 5, name: "History"),
  Category(id: 6, name: "Fiction"),
  Category(id: 7, name: "Literatur"),
  Category(id: 0, name: "More"),
];

Future<List<Book>?> getBooksByID({int? categoryId, int? genreId}) async {
  try {
    Uri path = Uri.parse("$url/book/get?category_id=$categoryId&genre_id=$genreId");
    final response = await http.get(path);
    List? data = json.decode(response.body)["data"];

    List<Book>? books = [];
    if (data != null) {
      print("masuk");
      data.forEach((element) {
        books.add(Book.fromJson(element));
      });
      return books;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String?> getImageFirebaseStorage(String? name) async {
  final storageRef = FirebaseStorage.instance.ref().child("images").child(name!);
  if (name == "") {
    return null;
  }

  try {
    final listResult = await storageRef.getDownloadURL();
    return listResult;
  } on FirebaseException catch (e) {
    return null;
  }
}

Future<bool> addWishlist({required int userId, required int bookId}) async {
  try {
    Uri path = Uri.parse("$url/wishlist/add");
    final response = await http.post(
      path,
      body: json.encode({"book_id": bookId, "user_id": userId}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<Wishlist?> getWishlist({required int bookId, required int userId}) async {
  try {
    Uri path = Uri.parse("$url/wishlist/get?book_id=$bookId&user_id=$userId");
    final response = await http.get(path);
    final data = json.decode(response.body)["data"];

    if (response.statusCode == 200) {
      Wishlist wishlist = Wishlist.fromJson(data);
      return wishlist;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<bool> deleteWishlist({required int id}) async {
  try {
    Uri path = Uri.parse("$url/wishlist/delete?id=$id");
    final response = await http.delete(path);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
