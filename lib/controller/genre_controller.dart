import 'dart:convert';

import 'package:mylibraryapps/utils/url.dart';

import '../data/models/category.dart';
import 'package:http/http.dart' as http;

import '../data/models/genre.dart';

Future<List<Genre>?> getGenresByCategoryID({int? categoryId = 0, int? genreId = 0}) async {
  try {
    List<Genre>? genres = [];

    Uri path = Uri.parse("$url/genre/get?category_id=$categoryId&genre_id=$genreId");
    final response = await http.get(path);
    if (response.statusCode == 200) {
      List? data = json.decode(response.body)["data"];
      if (data != null) {
        data.forEach((element) {
          genres.add(Genre.fromJson(element));
        });
        return genres;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
