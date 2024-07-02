import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:lets_buy/features/chat/services/stream_chat_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_row.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/chat/chat_page.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = 'details_screen';
  final ServiceModel serviceModel;
  const DetailsScreen({Key? key, required this.serviceModel}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool loading = true;
  bool state = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('تفاصيل الخدمة', style: appBarTextStyle),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: widget.serviceModel.imageUrl != null && widget.serviceModel.imageUrl != ''
                          ? Image.network(
                              widget.serviceModel.imageUrl!,
                              // widget.serviceModel.image!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                              child: const Text('لا يوجد صورة'),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Spacer(),
                        Chip(
                            backgroundColor: purple,
                            label: Text(
                              widget.serviceModel.category.name,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Chip(
                            backgroundColor: purple,
                            label: Text(
                              widget.serviceModel.type.name,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  TextRow(title: 'اسم الخدمة ', data: widget.serviceModel.name),
                  TextRow(title: 'الموقع', data: widget.serviceModel.location),
                  TextRow(title: 'السعر ', data: widget.serviceModel.price.toString() + ' ل.س'),
                  TextRow(title: 'وصف', data: widget.serviceModel.description),
                ],
              ),
            ),
            if (widget.serviceModel.userId != SharedPrefs.prefs.getInt('id'))
              Positioned(
                  bottom: 10,

                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButtonCustom(
                          text: 'ابدأ المحادثة',
                          color: purple,
                          textColor: dark,
                          onPressed: () {
                            _handlePressed(
                                types.User(
                                  id: widget.serviceModel.user.fcmUserId!,
                                  firstName: widget.serviceModel.user.name,
                                ),
                                context);
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FavoriteButton(
                          serviceModel: widget.serviceModel,
                        )
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    // navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key? key, required this.serviceModel}) : super(key: key);

  ServiceModel serviceModel;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        if (widget.serviceModel.isFavorite!) {
          await PostDbService().removeFromFavorites(serviceId: widget.serviceModel.id);
          widget.serviceModel = widget.serviceModel.copyWith(isFavorite: false);
        } else {
          await PostDbService().addToFavorites(serviceId: widget.serviceModel.id);
          widget.serviceModel = widget.serviceModel.copyWith(isFavorite: true);
        }
        await PostDbService().getFavoritesServices();
        isLoading = false;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: dark)),
        child: !isLoading
            ? Icon(
                !widget.serviceModel.isFavorite! ? Icons.favorite_border : Icons.favorite,
                color: dark,
              )
            : const CircularProgressIndicator(
                color: purple,
              ),
      ),
    );
  }
}
