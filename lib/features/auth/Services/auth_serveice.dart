import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';

class AuthService {
  Future<String> loginByEmail({required String email, required String password}) async {
    final url = Globals.serverURL + "/login";
    try {
      final response = await http.post(Uri.parse(url),
          headers: Globals.headers,
          body: json.encode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // final data = fetchedData['data'];
        SharedPrefs.prefs.setString('token', data['token']);
        SharedPrefs.prefs.setInt('id', data['user']['id']);
        SharedPrefs.prefs.setString('name', data['user']['name']);
        SharedPrefs.prefs.setString('phone', data['user']['phone']);
        SharedPrefs.prefs.setString('avatar', data['user']['avatar']);
        return 'succes';
      } else {
        return 'faluire';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone,
      String? avatar}) async {
    const url = "/register";

    final formMap = FormData.fromMap({
      'avatar': avatar != null
          ? MultipartFile.fromStream(
              () => File(avatar).readAsBytes().asStream(),
              File(avatar).lengthSync(),
              filename: avatar,
              contentType: MediaType('image', 'jpeg'),
            )
          : avatar
    }..addAll({'name': name, 'email': email, 'password': password, 'phone': phone}));

    final Dio dio = Dio();
    dio.options.baseUrl = Globals.serverURL;
    try {
      final response = await dio.post(url,
          data: formMap,
          options: Options(
            headers: Globals.headers,
          ));

      if (response.statusCode == 200) {
        final data = response.data;
        SharedPrefs.prefs.setString('token', data['token']);
        SharedPrefs.prefs.setInt('id', data['user_id']);
        return 'sucess';
      } else {
        return 'faluire';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        if (e.response?.statusCode == 422) {
          print('Validation error: ${e.response?.data}');
          return 'faluire';
        }
      } else {
        print('Error sending request: $e');
        return 'faluire';
      }
    } catch (e) {
      print('Unexpected error: $e');
      return 'faluire';
    }
    return 'faluire';
  }

  Future<String> completeProfile({
    required String fcmUserId,
    String? avatar,
    required String bio,
  }) async {
    const url = "/user/update";

    final formMap = FormData.fromMap({
      'avatar': avatar != null
          ? MultipartFile.fromStream(
              () => File(avatar).readAsBytes().asStream(),
              File(avatar).lengthSync(),
              filename: avatar,
              contentType: MediaType('image', 'jpeg'),
            )
          : avatar
    }..addAll({'bio': bio, 'fcm_user_id': fcmUserId}));

    final Dio dio = Dio();
    dio.options.baseUrl = Globals.serverURL;
    try {
      final response = await dio.put(url,
          data: formMap,
          options: Options(
            headers: Globals.headers,
          ));

      if (response.statusCode == 200) {
        final data = response.data;
        SharedPrefs.prefs.setString('token', data['token']);
        SharedPrefs.prefs.setInt('id', data['user_id']);
        return 'sucess';
      } else {
        return 'faluire';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        if (e.response?.statusCode == 422) {
          print('Validation error: ${e.response?.data}');
          return 'faluire';
        }
      } else {
        print('Error sending request: $e');
        return 'faluire';
      }
    } catch (e) {
      print('Unexpected error: $e');
      return 'faluire';
    }
    return 'faluire';
  }
}
