import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/posts/models/result_model.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:mime/mime.dart';

class PostDbService {
  //TODO: get ALL and filtter
  Future<Result?> getALlServices(
      {required ServiceType serviceType, int? typeId, String? location, String? name}) async {
    final url =
        Globals.serverURL + "/services?service_type=${serviceType.name}&type_id=$typeId&location=$location&name=$name";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
        },
      );
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return Result.fromJson(data);
      } else {
        print('errrrror');

        return null;
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  //TODO: get my posts
  Future<List<ServiceModel>> getMyServices() async {
    final url = Globals.serverURL + "/user_services";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
      },
    );
    // final data = fetchedData['data'];

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // print(response.body);

      return data.map((e) => ServiceModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  //TODO: get favorites
  Future<List<ServiceModel>> getFavoritesServices() async {
    final url = Globals.serverURL + "/favorit_services";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
        },
      );
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => ServiceModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  //TODO :: add to favorites
  Future<bool> addToFavorites({required int serviceId}) async {
    final url = Globals.serverURL + "/add_to_favorit";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({'service_id': serviceId}));
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> promotPost({required int serviceId, required int promotionValue}) async {
    final url = Globals.serverURL + "/add_search_value/$serviceId";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({
            'service_id': serviceId,
            "search_value": promotionValue,
          }));
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//TODO :: add to favorites
  Future<bool> removeFromFavorites({required int serviceId}) async {
    final url = Globals.serverURL + "/remove_from_favorit";

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({'service_id': serviceId}));
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //TODO: delete post
  Future<bool> deleteService({required int serviceId}) async {
    final url = Globals.serverURL + "/services/$serviceId";

    try {
      final response = await http.delete(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({'service_id': serviceId}));
      // final data = fetchedData['data'];

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //TODO: Add post
  Future<String> addNewService({
    String? image,
    required String name,
    required ServiceType serviceType,
    required int typeId,
    required int categoryId,
    required double price,
    required String description,
    required String location,
    final String? imageUrl,
  }) async {
    ///TODO: add price and service type enum

    final url = Globals.serverURL + "/services";
    String? img64;
    String? mimeType;
    if (image != null) {
      final bytes = File(image).readAsBytesSync();
      img64 = base64Encode(bytes);

      mimeType = lookupMimeType(image);

      print('mimeType: $mimeType');
    }

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({
            if (image != null) 'image': "data:$mimeType;base64,$img64",
            'name': name,
            'service_type': serviceType.name,
            'type_id': typeId,
            'category_id': categoryId,
            'description': description,
            'location': location,
            'price': price,
            'image_url': imageUrl,
          }));

      if (response.statusCode == 200) {
        final data = response.body;
        return 'success';
      } else {
        return 'error';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //TODO: update post
  //TODO: get typies
  //TODO: get categories
  //TODO:
}
