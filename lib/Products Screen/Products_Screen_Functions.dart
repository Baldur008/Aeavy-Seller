import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsScreenFunctions with ChangeNotifier {
  final String subCategoryId;
  bool showLoading = true;
  bool showError = false;
  List products = [];
  ProductsScreenFunctions(this.subCategoryId) {
    getProducts();
  }
  getProducts() async {
    try{
    Response response = await post(Uri.parse(
        "https://brands.aeavy.com/api/v1/registration/getProducts/" +
            subCategoryId));
    if (response.statusCode >= 400) {
      showError = true;
      showLoading = false;
      notifyListeners();
    }
    products = json.decode(response.body) as List;
    showLoading = false;
    showError = false;
    notifyListeners();}
    catch(e){
      showError = true;
      showLoading = false;
      print("Products Screen error without description");
      notifyListeners();
      return;
    }
  }
}
