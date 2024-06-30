import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/custom_progress.dart';
import 'package:lets_buy/core/config/widgets/custom_snackbar.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/features/auth/Services/authentecation_service.dart';
import 'package:lets_buy/features/auth/screens/sign_up_screen.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/log_in';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    PostDbService().getALlServices(serviceType: ServiceType.need_to);

    return Scaffold(
      backgroundColor: purple,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBoxLarge,
              sizedBoxLarge,
              Image.asset(
                'assets/images/logo-with-text.png',
                height: MediaQuery.sizeOf(context).height * 0.25,
              ),
              sizedBoxLarge,
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFieldCustom(
                          keyboardType: TextInputType.number, text: 'البريد الالكتروني', controller: emailController),
                      sizedBoxMedium,
                      TextFieldCustom(
                          keyboardType: TextInputType.number, text: 'كلمة المرور', controller: emailController),
                      sizedBoxLarge,
                      isLoading
                          ? const CustomProgress()
                          : ElevatedButtonCustom(
                              // color: Colors.black,
                              text: 'تسجيل دخول',
                              onPressed: () async {
                                isLoading = true;
                                setState(() {});
                                if (emailController.text.isEmpty || passwordcontroller.text.isEmpty) {
                                  showErrorSnackBar(context, 'يجب عليك ادخال البريد الالكتروني وكلمة السر');

                                  isLoading = false;
                                  setState(() {});
                                  return;
                                }
                                if (!emailController.text.contains('@')) {
                                  showErrorSnackBar(context, 'يجب ادخال بريد الكتروني صالح');

                                  isLoading = false;
                                  setState(() {});
                                  return;
                                }

                                final result = await FlutterFireAuthServices().signIn(
                                    email: emailController.text, password: passwordcontroller.text, context: context);

                                if (result != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                                }
                              }),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ليس لديك حساب؟',
                            style: TextStyle(color: dark, fontSize: 16, fontFamily: font),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            child: const Text('انضم الينا',
                                style: TextStyle(
                                    color: purple, fontSize: 16, fontFamily: font, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignUpScreen.routeName);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
