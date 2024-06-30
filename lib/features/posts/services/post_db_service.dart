import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/features/posts/models/result_model.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';

class PostDbService {
  //TODO: get ALL and filtter
  Future<Result?> getALlServices(
      {required ServiceType serviceType, int? typeId, String? location, String? name}) async {
    final url =
        Globals.serverURL + "/services?service_type=${serviceType.name}&type_id=$typeId&location=$location&name=$name";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
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

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
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

  //TODO: get favorites
  Future<List<ServiceModel>> getFavoritesServices() async {
    final url = Globals.serverURL + "/favorit_services";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
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
      final response =
          await http.post(Uri.parse(url), headers: Globals.headers, body: json.encode({'service_id': serviceId}));
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
      final response =
          await http.post(Uri.parse(url), headers: Globals.headers, body: json.encode({'service_id': serviceId}));
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
      final response =
          await http.post(Uri.parse(url), headers: Globals.headers, body: json.encode({'service_id': serviceId}));
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
  Future<ServiceModel?> addNewService({
    String? image,
    required String name,
    required ServiceType serviceType,
    required int typeId,
    required int categoryId,
    required double price,
    required String description,
    required String location,
  }) async {
    ///TODO: add price and service type enum

    final url = Globals.serverURL + "/services";

    try {
      final formMap = FormData.fromMap({
        'image': image != null
            ? MultipartFile.fromStream(
                () => File(image).readAsBytes().asStream(),
                File(image).lengthSync(),
                filename: image,
                contentType: MediaType('image', 'jpeg'),
              )
            : image
      }..addAll({
          'name': name,
          'service_type': serviceType.name,
          'type_id': typeId,
          'category_id': categoryId,
          'description': description,
          'location': location,
          'price': price
        }));

      final response = await Dio().post(url, data: formMap, options: Options(headers: Globals.headers));

      if (response.statusCode == 200) {
        final data = response.data;

        return ServiceModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //TODO: update post
  //TODO: get typies
  //TODO: get categories
  //TODO:
}
