import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:mime/mime.dart';

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
        SharedPrefs.prefs.setString('avatar', data['user']['avatar'] ?? '');
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

    final formMap = FormData.fromMap({}..addAll({'name': name, 'email': email, 'password': password, 'phone': phone}));

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
    String? imageUrl,
    required String bio,

  }) async {
    final url = Globals.serverURL + "/user/update";

    String? img64;
    String? mimeType;
    if (avatar != null) {
      final bytes = File(avatar).readAsBytesSync();
      img64 = base64Encode(bytes);

      mimeType = lookupMimeType(avatar);

      print('mimeType: $mimeType');
    }

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode(
            {'avatar': "data:$mimeType;base64,$img64", 'fcm_user_id': fcmUserId, 'bio': bio, 'image_url': imageUrl},
          ));

      if (response.statusCode == 200) {
        final ss = response.body;
        final data = json.decode(ss);
        SharedPrefs.prefs.setInt('id', data['id']);
        SharedPrefs.prefs.setString('name', data['name']);
        SharedPrefs.prefs.setString('phone', data['phone']);
        SharedPrefs.prefs.setString('avatar', data['avatar'] ?? '');

        return 'sucess';
      } else {
        return 'faluire';
      }
    } catch (e) {
      return 'faluire';
    }
  }
}
