import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/models/type_model.dart';
import 'package:lets_buy/features/posts/services/types_categories_db_service.dart';

class TypesDropdown extends StatefulWidget {
  const TypesDropdown({Key? key, required this.onChanged, required this.selectedType}) : super(key: key);
  final void Function(TypeModel?)? onChanged;
  final TypeModel? selectedType;

  @override
  _TypesDropdownState createState() => _TypesDropdownState();
}

class _TypesDropdownState extends State<TypesDropdown> {
  final TypesCategoriesDbService _categoryService = TypesCategoriesDbService();
  List<TypeModel> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    try {
      List<TypeModel> categories = await _categoryService.getAllTypes();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: dark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<TypeModel>(
                isExpanded: true,
                dropdownColor: white,
                elevation: 10,
                iconEnabledColor: purple,
                style: style1,
                alignment: AlignmentDirectional.centerStart,
                focusColor: purple,
                isDense: true,
                hint: const Text(
                  "اختر النوع",
                  style: TextStyle(color: dark),
                ),
                value: widget.selectedType,
                onChanged: widget.onChanged,
                items: _categories.map<DropdownMenuItem<TypeModel>>((TypeModel category) {
                  return DropdownMenuItem<TypeModel>(
                    value: category,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(category.name),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
