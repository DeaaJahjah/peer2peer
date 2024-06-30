import 'package:flutter/material.dart';
import 'package:lets_buy/features/posts/models/category_model.dart';
import 'package:lets_buy/features/posts/services/types_categories_db_service.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final TypesCategoriesDbService _categoryService = TypesCategoriesDbService();
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    try {
      List<Category> categories = await _categoryService.getAllCategories();
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
        ? const CircularProgressIndicator()
        : DropdownButton<Category>(
            hint: const Text("اختر تصنيف"),
            value: _selectedCategory,
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: _categories.map<DropdownMenuItem<Category>>((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
          );
  }
}
