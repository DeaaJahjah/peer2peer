import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/item_custome.dart';

class FavouriteScreen extends StatefulWidget {
  static const String routeName = '/favourite_screen';
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: purple,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('المحفوظات', style: appBarTextStyle)),
      body: FutureBuilder<List<ServiceModel>?>(
          future: PostDbService().getFavoritesServices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var favorites = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  var post = favorites[index];
                  return ItemCustom(
                    urlImage: post.imageUrl!,
                    address: post.location,
                    type: post.type.name,
                    category: post.category.name,
                    price: post.price.toString(),
                    onDelete: () async {
                      await PostDbService().removeFromFavorites(serviceId: post.id);
                      setState(() {});
                    },
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
