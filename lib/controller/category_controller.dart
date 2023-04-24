import 'dart:convert';

import 'package:mylibraryapps/utils/url.dart';

import '../data/models/category.dart';
import 'package:http/http.dart' as http;

Future<List<Category>?> getCategories() async {
  try {
    List<Category>? genres = [];

    Uri path = Uri.parse("$url/category/get");
    final response = await http.get(path);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)["data"];
      data.forEach((element) {
        genres.add(Category.fromJson(element));
      });

      return genres;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
