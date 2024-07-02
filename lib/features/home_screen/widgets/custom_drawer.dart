import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/extensions/firebase.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/auth/Services/authentecation_service.dart';
import 'package:lets_buy/features/posts/screens/add_post.dart';
import 'package:lets_buy/features/posts/screens/favourite_screen.dart';
import 'package:lets_buy/features/posts/screens/my_posts_screen.dart';
import 'package:lets_buy/features/profile/profile_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () async {
              await Navigator.of(context).pushNamed(ProfileScreen.routeName);
              setState(() {});
            },
            child: UserAccountsDrawerHeader(
              accountName: Text(SharedPrefs.prefs.getString('name') ?? '', style: const TextStyle(color: Colors.black)),
              accountEmail: null,
              currentAccountPicture: context.logedInUser!.photoURL == null || context.logedInUser!.photoURL == ''
                  ? const CircleAvatar(
                      child: Icon(Icons.person),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(context.logedInUser!.photoURL!),
                    ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.black),
            title: const Text('اضافة خدمة', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushNamed(AddPostScreen.routeName);

              // Handle add service action
            },
          ),
          ListTile(
            leading: const Icon(Icons.build, color: Colors.black),
            title: const Text('خدماتي', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Handle my services action
              Navigator.of(context).pushNamed(MyPostsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.black),
            title: const Text('المفضلة', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushNamed(FavouriteScreen.routeName);
              // Handle my favorites action
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('تسجيل خروج', style: TextStyle(color: Colors.black)),
            onTap: () {
              SharedPrefs.prefs.clear();
              // SharedPrefs.prefs.;

              FlutterFireAuthServices().signOut(context);
              // Handle sign out action
            },
          ),
        ],
      ),
    );
  }
}
