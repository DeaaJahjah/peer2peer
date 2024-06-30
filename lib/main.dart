import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/app.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPrefs.prefs = await SharedPreferences.getInstance();
  // final client = StreamChatClient(
  //   streamKey,
  // );
  runApp(const App(
      // client: client,
      ));
}
