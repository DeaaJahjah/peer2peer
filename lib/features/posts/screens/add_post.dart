import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/drop_down_custom.dart';
import 'package:lets_buy/core/config/widgets/elevated_button_custom.dart';
import 'package:lets_buy/core/config/widgets/text_field_custome.dart';
import 'package:lets_buy/features/auth/Services/file_services.dart';
import 'package:lets_buy/features/posts/models/category_model.dart';
import 'package:lets_buy/features/posts/models/type_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/category_dropdown.dart';
import 'package:lets_buy/features/posts/widgets/types_dropdown.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/add_post';
  const AddPostScreen({Key? key}) : super(key: key);
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Category? _selectedCategory;
  TypeModel? _selectedType;

  String productStatus = productStatusList.first;
  String symbol = 'Ls';
  String postType = 'حمص';

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
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
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: purple,
        elevation: 0.0,
        title: const Text('اضافة خدمة', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        children: [
          InkWell(
              onTap: () {
                _pickImage();
                setState(() {});
              },
              child: (pickedimage == null)
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(25),
                      height: 150,
                      child: Image.asset(
                        'assets/images/select_img.png',
                        width: 75,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: Image.file(
                        imageFile!,
                        height: 200,
                        fit: BoxFit.contain,
                      ))),
          sizedBoxLarge,
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'نوع الخدمة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  flex: 1,
                  child: DropDownCustom(
                    categories: productStatusList,
                    selectedItem: productStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        productStatus = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'اختر التصنيف',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: CategoryDropdown(
                  selectedCategory: _selectedCategory,
                  onChanged: (Category? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'اختر النوع',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TypesDropdown(
                  selectedType: _selectedType,
                  onChanged: (TypeModel? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'اختر المدينة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                flex: 1,
                child: DropDownCustom(
                  categories: cities,
                  selectedItem: postType,
                  onChanged: (String? newValue) {
                    setState(() {
                      postType = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              title('العنوان'),
              Expanded(child: TextFieldCustom(text: '', controller: addressController)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              title('السعر'),
              Expanded(
                  child: TextFieldCustom(
                text: '',
                controller: priceController,
                keyboardType: TextInputType.number,
              )),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                // decoration: BoxDecoration(border: Border.all(color: purple), borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  children: [
                    Text(
                      'ل.س',
                      style: style1,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              title('الوصف'),
              Expanded(
                  child: TextFieldCustom(
                text: '',
                controller: descController,
                maxLine: 8,
              )),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: !isLoading
                ? ElevatedButtonCustom(
                    text: 'اضافة',
                    color: purple,
                    onPressed: () async {
                      if (_selectedCategory == null || _selectedType == null) {
                        var snackBar = const SnackBar(
                          content: Text(
                            'الرجاء اختيار تصنيف',
                            style: style2,
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      if (imageFile == null) {
                        var snackBar = const SnackBar(
                          content: Text(
                            'الرجاء اختيار صورة',
                            style: style2,
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      //change the state to loading
                      setState(() {
                        isLoading = true;
                      });
                      String? imageUrl;

                      if (imageFile != null) {
                        imageUrl = await FileService().uploadeimage(fileName, imageFile!, context);
                      }

                      final res = await PostDbService().addNewService(
                          name: addressController.text,
                          serviceType:
                              productStatus == productStatusList.first ? ServiceType.need_to : ServiceType.provided_to,
                          typeId: _selectedType!.id,
                          categoryId: _selectedCategory!.id,
                          price: double.parse(priceController.text),
                          description: descController.text,
                          location: postType,
                          image: imageFile?.path,
                          imageUrl: imageUrl);

                      setState(() {
                        isLoading = false;
                      });
                      if (res == 'success') {
                        SnackBar snackBar = const SnackBar(content: Text('تمت الاضافة بنجاح'));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        context.read<SearchProvider>().getServices();
                        Navigator.of(context).pop();
                      } else {
                        SnackBar snackBar = SnackBar(content: Text(res));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      //   //change the state to notSet
                    })
                : const CircularProgressIndicator(
                    color: purple,
                  ),
          )
        ],
      ),
    );
  }

  title(String title) {
    return SizedBox(
      width: 80,
      child: Text(
        title,
        style: style1,
      ),
    );
  }
}
