import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class PendingScreenFunctions with ChangeNotifier {
  PendingScreenFunctions(this.id);
  final String id;
  bool showLoading = false;
  bool showAddbankDetails = false;
  checkStatus() async {
    try {
      print(id);
      showLoading = true;
      notifyListeners();
      Response response = await get(Uri.parse(
          r"https://brands.aeavy.com/api/v1/registration/getstatus/" + id));
      var body = json.decode(response.body);
      print(body);
      if (response.statusCode >= 400) throw "Server Error";
      if (body["message"] == "Seller Approved") {
        showLoading = false;
        showAddbankDetails = true;
        notifyListeners();
        return;
      }
      showLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      showLoading = false;
      notifyListeners();
    }
  }
}
