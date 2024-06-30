import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/widgets/porduct_card.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  bool isSwitched = true;
  bool loading = true;

  // String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    // context.read<UserInfoProvider>().getUserInfo(uid: uid).then((value) {
    //   setState(() {
    //     loading = false;
    //   });
    // });
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // FlutterFireAuthServices().signOut(context);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            currentIndex: currentIndex,
            backgroundColor: Colors.black,
            selectedItemColor: purple,
            unselectedItemColor: white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'طلبات'),
              BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'عروض'),
            ]),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: purple,
          elevation: 0.0,
          leading: const Icon(Icons.message),
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const TextField(
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: darkPurple,
                  filled: true,
                  hintText: 'ابحث هنا'),
            ),
          ),
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const SizedBox(width: 65),
          //     Image.asset(
          //       'assets/images/logo.png',
          //       // scale: 4,
          //       height: 30,
          //     ),
          //     const Text('Let\'s Buy', style: appBarTextStyle),
          //   ],
          // ),
        ),
        body: ListView(
          children: const [ServiceCard()],
        )

        // (!loading)
        //     ? FutureBuilder<List<ServiceModel>>(
        //         // key: Keys.postsStreamKey,
        //         future: Future.value(),
        //         // stream: PostDbService().getPostsByCategory(category),
        //         builder: (context, snapshot) {
        //           if (snapshot.hasData) {
        //             List<ServiceModel> posts = snapshot.data!;
        //             print(posts.length);

        //             return ListView.builder(
        //                 itemCount: posts.length,
        //                 itemBuilder: (context, i) {
        //                   return ServiceCard(
        //                     service:posts[i],
        //                   );
        //                 });
        //           }
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return const Center(
        //               child: CircularProgressIndicator(color: purple),
        //             );
        //           }
        //           return const SizedBox.shrink();
        //         })
        // : const Center(child: CircularProgressIndicator(color: purple)),
        );
  }
}
