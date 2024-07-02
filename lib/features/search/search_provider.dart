import 'package:flutter/foundation.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/features/posts/models/category_model.dart' as category_model;
import 'package:lets_buy/features/posts/models/result_model.dart';
import 'package:lets_buy/features/posts/models/type_model.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';

class SearchProvider extends ChangeNotifier {
  DataState dataState = DataState.notSet;
  category_model.Category? selectedCategory;
  TypeModel? selectedType;
  ServiceType serviceType = ServiceType.need_to;
  String location = cities[0];
  String? name;

  //*********** */
  Result? result;
  Future<void> getServices() async {
    dataState = DataState.loading;
    notifyListeners();
    result = await PostDbService()
        .getALlServices(serviceType: serviceType, location: location, name: name, typeId: selectedType?.id);

    if (result == null) {
      dataState = DataState.failure;
    } else {
      dataState = DataState.done;
    }

    notifyListeners();
  }

  void clear() {
    name = null;
    selectedCategory = null;
    selectedType = null;
    location = cities[0];
    notifyListeners();
  }
}
