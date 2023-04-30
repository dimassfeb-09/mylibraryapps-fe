import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/models/wishlist.dart';
import '../utils/url.dart';

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

Future<Wishlist?> getWishlist({int? bookId, required int userId}) async {
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

Future<List<Wishlist>?> getWishlistByUserID({required int userId}) async {
  try {
    Uri path = Uri.parse("$url/wishlist/get?user_id=$userId");
    final response = await http.get(path);
    List data = json.decode(response.body)["data"];

    List<Wishlist>? wishlists = [];

    if (response.statusCode == 200) {
      data.forEach((e) {
        wishlists.add(Wishlist.fromJson(e));
      });
      return wishlists;
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
