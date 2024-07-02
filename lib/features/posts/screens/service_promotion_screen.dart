import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/widgets/custom_snackbar.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:provider/provider.dart';

class ServicePromotionScreen extends StatefulWidget {
  const ServicePromotionScreen({Key? key, required this.serviceId}) : super(key: key);
  final int serviceId;

  @override
  State<ServicePromotionScreen> createState() => _ServicePromotionScreenState();
}

class _ServicePromotionScreenState extends State<ServicePromotionScreen> {
  int _selectedValue = 10000;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  bool isLoading = false;
  void _promotePost() async {
    setState(() {
      isLoading = true;
    });
    await PostDbService().promotPost(serviceId: widget.serviceId, promotionValue: _selectedValue);
    // Implement your promotion logic here
    await context.read<SearchProvider>().getServices();

    Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
    showSuccessSnackBar(context, 'تم الدفع بنجاح');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الترويج للمنشور'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/pro.jpg', // Replace with your image URL
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'اختر قيمة الترويج',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'قم باختيار قيمة الترويج المناسبة لمنشورك:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            RadioListTile<int>(
              value: 10000,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
              title: const Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 10),
                  Text('10000 ل.س'),
                ],
              ),
            ),
            RadioListTile<int>(
              value: 20000,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
              title: const Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 10),
                  Text('20000 ل.س'),
                ],
              ),
            ),
            RadioListTile<int>(
              value: 30000,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
              title: const Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 10),
                  Text('30000 ل.س'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: !isLoading
                  ? ElevatedButtonCustom(
                      onPressed: _promotePost,
                      textColor: white,
                      text: 'ترويج',
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
