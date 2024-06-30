import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/text_row.dart';
// import 'package:lets_buy/features/chat/services/stream_chat_service.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';

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
      backgroundColor: dark,
      // appBar: AppBar(),
      body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(state);
            return false;
          },
          child: SafeArea(
              child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.serviceModel.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //         width: MediaQuery.of(context).size.width,
                    //         height: 150,
                    //         child: const Center(
                    //             child: Text(
                    //           'لا يوجد صور',
                    //           style: style1,
                    //         )),
                    //       ),

                    TextRow(title: 'العنوان ', data: widget.serviceModel.location),
                    TextRow(title: 'السعر ', data: widget.serviceModel.price.toString() + ' ل.س'),
                    TextRow(
                        title: 'التصنيف',
                        data: widget.serviceModel.category.name + ' - ' + widget.serviceModel.type.name),
                    const TextRow(title: 'الوصف ', data: ''),
                    TextRow(title: '', data: widget.serviceModel.description),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}
