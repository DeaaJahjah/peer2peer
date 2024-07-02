import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/screens/my_posts_screen.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/services/user_db_service.dart';
import 'package:lets_buy/features/profile/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile_screen';
  const ProfileScreen({Key? key, this.userId}) : super(key: key);
  final int? userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('الملف الشخصي', style: appBarTextStyle),
      ),
      body: FutureBuilder<UserModel?>(
          future: UserDbServices().getUser(userId: widget.userId ?? SharedPrefs.prefs.getInt('id')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    // height: 100,

                    child: Container(
                      // radius: 150,
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: snapshot.data!.imageUrl != null
                          ? CircleAvatar(
                              backgroundColor: purple,
                              minRadius: 200,
                              maxRadius: 200,
                              backgroundImage: NetworkImage(snapshot.data!.imageUrl!),
                            )
                          : const CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: dark,
                              ),
                            ),
                    ),
                  ),
                  sizedBoxSmall,
                  Text(
                    snapshot.data!.name,
                    style: const TextStyle(color: dark, fontFamily: font, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    snapshot.data!.email,
                    style: const TextStyle(color: dark, fontFamily: font, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.description,
                        color: dark,
                        size: 25,
                      ),
                      Text(snapshot.data!.bio ?? 'لا يوجد وصف',
                          style: const TextStyle(color: dark, fontFamily: font, fontSize: 18)),
                    ],
                  ),
                  if (widget.userId == null)
                    Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(dark.withOpacity(0.2)),
                        ),
                          onPressed: () async {
                            await Navigator.of(context).pushNamed(MyPostsScreen.routeName);
                            setState(() {});
                        },
                        child: FutureBuilder<List<ServiceModel>>(
                            future: PostDbService().getMyServices(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int length = snapshot.data!.length;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: dark,
                                      radius: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(length.toString(),
                                              style: const TextStyle(color: white, fontSize: 10)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'الخدمات',
                                      style: TextStyle(
                                          color: white, fontFamily: font, fontSize: 14, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator(color: dark),
                              );
                            })),
                  ),
                  if (widget.userId == null)
                    Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(dark.withOpacity(0.2)),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(UpdateProfileScreen.routeName, arguments: snapshot.data!)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                                color: dark,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'تعديل الملف الشخصي',
                              style:
                                  TextStyle(color: white, fontFamily: font, fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  
                ]),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: purple,
              ));
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
