import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/extensions/firebase.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/features/auth/Services/auth_serveice.dart';
import 'package:lets_buy/features/auth/Services/authentecation_service.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:path/path.dart' as path;

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);
      setState(() {});
      print(imageFile!.path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: dark,
      appBar: AppBar(
        // backgroundColor: dark,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('انشاء حساب', style: appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Card(
            color: white,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(children: [
                sizedBoxLarge,
                InkWell(
                    onTap: () {
                      _pickImage();
                      setState(() {});
                    },
                    child: (pickedimage == null)
                        ? Container(
                            decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(25),
                            child: Image.asset(
                              'assets/images/select_img.png',
                              width: 75,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(20),
                            child: Image.file(imageFile!))),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'الاسم', controller: userName, icon: Icons.person),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'البريد الالكتروني', controller: email, icon: Icons.email),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'كلمة المرور', controller: passwordController, icon: Icons.lock),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم الهاتف',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(10)),
                          child: const Text('+963', style: TextStyle(fontWeight: FontWeight.w800)),
                        )),
                        Expanded(
                          flex: 4,
                          child: TextFieldCustom(
                              text: 'رقم الهاتف',
                              controller: phoneController,
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(text: 'وصف عن ماذا تقدم', controller: address, icon: Icons.description),
                const SizedBox(
                  height: 24,
                ),
                !isLoading
                    ? ElevatedButtonCustom(
                        color: purple,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (imageFile == null) {
                              var snackBar = const SnackBar(content: Text('الرجاء اخيار صورة'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              return;
                            }

                            //TODO:: login by firebase

                            setState(() {
                              isLoading = true;
                            });

                            final re = await FlutterFireAuthServices()
                                .signUp(email: email.text, password: passwordController.text, context: context);

                            if (re == null) {
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            final res = await AuthService().signUp(
                                email: email.text,
                                password: passwordController.text,
                                name: userName.text,
                                phone: phoneController.text,
                                avatar: imageFile!.path);

                            if (res == 'faluire') {
                              setState(() {
                                isLoading = false;
                              });
                              const snakBar = SnackBar(content: Text('حدث خطأ عند انشاء الحساب'));
                              ScaffoldMessenger.of(context).showSnackBar(snakBar);
                            } else {
                              final res = await AuthService().completeProfile(
                                  fcmUserId: context.logedInUser!.uid, bio: address.text, avatar: imageFile!.path);

                              Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                            }
                          } else {
                            var snackBar = const SnackBar(content: Text('جميع الحقول مطلوبة'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        text: 'انشاء',
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                        color: purple,
                      )),
                sizedBoxLarge
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
