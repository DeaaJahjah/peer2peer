import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/features/posts/models/category_model.dart';
import 'package:lets_buy/features/posts/models/type_model.dart';

class TypesCategoriesDbService {
  Future<List<TypeModel>> getAllTypes() async {
    final url = Globals.serverURL + "/types";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
      );
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => TypeModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Category>> getAllCategories() async {
    final url = Globals.serverURL + "/categories";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
      );
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => Category.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
