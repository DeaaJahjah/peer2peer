import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/utils/shred_prefs.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';
import 'package:lets_buy/features/posts/screens/details_screen.dart';
import 'package:lets_buy/features/posts/screens/service_promotion_screen.dart';
import 'package:lets_buy/features/profile/profile_screen.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.service, this.showPayPromotionButton = false, this.onPressed})
      : super(key: key);
  final ServiceModel service;
  final Function()? onPressed;
  final bool showPayPromotionButton;
  @override
  Widget build(BuildContext context) {
    print('${service.imageUrl}');
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(
            serviceModel: service,
          ),
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: service.user.id),
                  ));
                },
                child: Row(
                  children: [
                    service.user.imageUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              service.user.imageUrl!,
                            ), // Replace with actual image URL
                            radius: 30,
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              service.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        service.imageUrl!, // Replace with actual image URL
                        height: 150,

                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 150,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
                      child: const Text('لا يوجد صورة'),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Spacer(),
                  Chip(
                      backgroundColor: purple,
                      label: Text(
                        service.category.name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                      backgroundColor: purple,
                      label: Text(
                        service.type.name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              sizedBoxMedium,
              Row(
                children: [
                  const Text('اسم الخدمة ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(service.name, style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      Text(service.location),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                service.description,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${service.price}\ل.س',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              if (service.userId == SharedPrefs.prefs.getInt('id')) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (onPressed != null)
                      ElevatedButtonCustom(
                        text: 'حذف',
                        color: Colors.red,
                        onPressed: onPressed,
                      ),
                    if (showPayPromotionButton)
                      ElevatedButtonCustom(
                        text: 'ترويج للخدمة',
                        color: Colors.green,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ServicePromotionScreen(serviceId: service.id),
                          ));
                        },
                      ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}


// Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       service.name,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           size: 16,
//                         ),
//                         Text(service.location),
//                       ],
//                     ),
//                   ],
//                 ),