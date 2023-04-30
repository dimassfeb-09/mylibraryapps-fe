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

Future<Book?> getBooksByBookID({int? bookId}) async {
  try {
    Uri path = Uri.parse("$url/book/get?id=$bookId");
    final response = await http.get(path);
    Map<String, dynamic>? data = json.decode(response.body)["data"];

    Book? book;
    if (data != null) {
      book = Book.fromJson(data);
      return book;
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

Future<List<Book>?> getNewBooks() async {
  try {
    Uri path = Uri.parse("$url/book/get/new");
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
    return null;
  }
}
