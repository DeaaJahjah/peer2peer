import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/features/auth/Providers/auth_state_provider.dart';
import 'package:lets_buy/features/auth/Services/auth_serveice.dart';
import 'package:lets_buy/features/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
//     as streamSdk;

class FlutterFireAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    // await streamSdk.StreamChatCore.of(context).client.disconnectUser();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Future<UserCredential?> signIn(
      {required String email, required String password, required BuildContext context}) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      String result = await AuthService().loginByEmail(email: email, password: password);

      if (result == 'faluire') {
        const snakBar = SnackBar(content: Text('حدث خطأ عند انشاء الحساب'));
        ScaffoldMessenger.of(context).showSnackBar(snakBar);
        return null;
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }

  Future<UserCredential?> signUp(
      {required String email, required String password, required BuildContext context}) async {
    context.read<AuthSataProvider>().changeAuthState(newState: AuthState.waiting);
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return user;
    } on FirebaseAuthException catch (e) {
      context.read<AuthSataProvider>().changeAuthState(newState: AuthState.notSet);
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }
}
