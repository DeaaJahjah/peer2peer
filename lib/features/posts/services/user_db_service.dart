import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';

class UserDbServices {
  Future<UserModel?> getUser({required userId}) async {
    final url = Globals.serverURL + "/user/$userId";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return UserModel.fromJson({
          "id": data['id'],
          "name": data['name'],
          "email": data['email'],
          "phone": data['phone'],
          "avatar": data['avatar'],
          "bio": data['bio'],
          "image_url": data['image_url'],
        });
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> updateUser(UserModel user) async {
    final url = Globals.serverURL + "/user/update";

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
          },
          body: json.encode({
            "name": user.name,
            // "avatar": user.imgUrl,
            // "email": user.email,
            "phone": user.phoneNumber,
            "bio": user.bio,
            "image_url": user.imageUrl,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedPrefs.prefs.setString('name', data['name']);
        return UserModel.fromJson({
          "id": data['id'],
          "name": data['name'],
          "avatar": data['avatar'],
          "email": data['email'],
          "phone": data['phone'],
          "bio": data['bio'],
          "image_url": data['image_url'],
        });
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
