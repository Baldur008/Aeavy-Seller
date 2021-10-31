import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class SubCategoriesFunctions with ChangeNotifier {
  String categoryId;
  bool showLoading = true;
  bool showError = false;
  List subCategories = [];
  SubCategoriesFunctions(this.categoryId) {
    getSubCategories();
  }
  getSubCategories() async {
    try {
      showLoading = true;
      Response response = await get(Uri.parse(
          "https://brands.aeavy.com/api/v1/subcategory/getAllSubCategories/" +
              categoryId));
      if (response.statusCode >= 400) {
        showError = true;
        showLoading = false;
        print("Sub categories Screen" + response.statusCode.toString());
        notifyListeners();
        return;
      }
      subCategories = json.decode(response.body)["data"] as List;
      showLoading = false;
      notifyListeners();
    } catch (e) {
      showError = true;
      showLoading = false;
      print("Sub categories Screen error without description");
      notifyListeners();
      return;
    }
  }
}
