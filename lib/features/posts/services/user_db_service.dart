import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lets_buy/core/utils/globals.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';

class UserDbServices {
  Future<UserModel?> getUser({required userId}) async {
    final url = Globals.serverURL + "/user/$userId";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Globals.headers,
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
        });
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
