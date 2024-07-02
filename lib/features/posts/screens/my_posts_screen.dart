import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/porduct_card.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:provider/provider.dart';

class MyPostsScreen extends StatefulWidget {
  static const String routeName = '/post_screen';
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: purple,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('منشوراتي', style: appBarTextStyle)),
      body: FutureBuilder<List<ServiceModel>>(
          future: PostDbService().getMyServices(),
          builder: (context, snapshot) {
            print(snapshot.error);
            if (snapshot.hasData) {
              var myPosts = snapshot.data!;
              print(myPosts.length);

              if (myPosts.isEmpty) {
                return const Center(child: Text('لا يوجد منشورات', style: style1));
              }
              return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  itemCount: myPosts.length,
                  itemBuilder: (context, index) {
                    var post = myPosts[index];
                    return ServiceCard(
                      service: post,
                      showPayPromotionButton: true,
                      onPressed: () async {
                        await PostDbService().deleteService(serviceId: post.id);
                        await PostDbService().getMyServices();
                        context.read<SearchProvider>().getServices();

                        setState(() {});
                      },
                    );
                    // ItemCustom(
                    //   urlImage: post.image,
                    //   address: post.location,
                    //   type: post.type.name,
                    //   category: post.category.name,
                    //   price: post.price.toString(),
                    //   onDelete: () async {

                    //   },
                    //   onEdit: () {
                    //     Navigator.pushNamed(context, EditPostScreen.routeName, arguments: post);
                    //   },
                    // );
                  });
            }
            if (snapshot.hasError) {
              const Center(child: Text('حدث خطأ', style: style1));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return const SizedBox();
          }),
    );
  }
}
