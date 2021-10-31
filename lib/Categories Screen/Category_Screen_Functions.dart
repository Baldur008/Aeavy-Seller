import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class CategoryScreenFunctions with ChangeNotifier {
  late String brandId;
  List categories = [];
  bool showLoading = true;
  bool showError = false;
  CategoryScreenFunctions(String brandId) {
    this.brandId = brandId;
    getCategories();
  }
  getCategories() async {
    try {
      showLoading = true;

      Response response = await get(Uri.parse(
          "https://brands.aeavy.com/api/v1/category/getAllCategories/" +
              brandId));
      if (response.statusCode >= 400) {
        showError = true;
        showLoading = false;
        print("Categories Screen Error" + response.statusCode.toString());
        notifyListeners();
        return;
      }
      showError = false;

      this.categories = json.decode(response.body)["data"] as List;
      print(this.categories);
      showLoading = false;
      notifyListeners();
    } catch (e) {
      showError = true;
      return;
    }
  }
}
