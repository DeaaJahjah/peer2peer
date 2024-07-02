//port number

import 'package:lets_buy/core/utils/shred_prefs.dart';

class Globals {
  static const _port = "8000";
  static String serverURL = "http://10.0.2.2:8000/api";
  static String serverImageURL = "http://10.0.2.2:8000/images/";

//127.0.0.1

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs.prefs.getString('token')}',
  };
}
