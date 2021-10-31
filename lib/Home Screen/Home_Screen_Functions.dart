import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HomeScreenFunctions with ChangeNotifier {
  bool showLoadingBrands = false;
  bool showError = false;
  List brands = [];

  HomeScreenFunctions() {
    getAllBrands();
  }

  getAllBrands() async {
    try {
      showLoadingBrands = true;
      notifyListeners();
      Response response = await get(
          Uri.parse("https://brands.aeavy.com/api/v1/brands/getAllBrands"));
      if (response.statusCode >= 400) {
        showError = true;
        showLoadingBrands = false;
        print("Home Screen Error" + response.statusCode.toString());showError = true;
      showLoadingBrands = false;

      notifyListeners();
        notifyListeners();
      }
      brands = json.decode(response.body)["data"] as List;
      showLoadingBrands = false;
      notifyListeners();
    } catch (e) {
      showError = true;
      showLoadingBrands = false;

      notifyListeners();
    }
  }
}
