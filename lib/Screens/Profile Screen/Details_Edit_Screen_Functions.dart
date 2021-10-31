import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DetailsEditScreenFunctions with ChangeNotifier {
  String businessName;
  String sellerName;
  String phoneNumber;
  String email;
  String contactPersonName;
  final String id;
  final Function callBack;

  bool loading = false;
  bool allowEdit = false;
  bool showError = false;
  bool showSuccesful = false;
  Map<String, TextEditingController> textEditingControllers = {};

  DetailsEditScreenFunctions(
      {required this.businessName,
      required this.sellerName,
      required this.phoneNumber,
      required this.email,
      required this.contactPersonName,
      required this.id,
      required this.callBack}) {
    textEditingControllers = {
      "Business Name": TextEditingController(text: businessName),
      "Seller Name": TextEditingController(text: sellerName),
      "Contact Person Name": TextEditingController(text: contactPersonName),
      "Phone Number": TextEditingController(text: phoneNumber),
      "Email": TextEditingController(text: email),
    };
  }

  allowEditToggle() {
    loading = false;
    showError = false;
    showSuccesful = false;
    allowEdit = !allowEdit;
    notifyListeners();
  }

  updateSellerApi() async {
    try {
      loading = true;
      allowEdit = false;
      notifyListeners();
      await put(
          Uri.parse(
              "https://brands.aeavy.com/api/v1/registration/update_seller"),
          body: {
            "user_id": id,
            "city": "Delhi",
            "seller_name": textEditingControllers["Seller Name"]?.text,
            "busniess_name": textEditingControllers["Business Name"]?.text,
            "email": textEditingControllers["Email"]?.text,
            "gst": "jnkals",
            "phone": textEditingControllers["Phone Number"]?.text,
            "contact_person": textEditingControllers["Contact Person Name"]?.text
          });
      // var body = json.decode(response.body);
      // if (!body["status"]) throw "Error";
      await callBack(
        businessName: textEditingControllers["Business Name"]?.text,
        phoneNumber: textEditingControllers["Phone Number"]?.text,
        sellerName: textEditingControllers["Seller Name"]?.text,
        contactPersonName: textEditingControllers["Contact Person Name"]?.text,
        email: textEditingControllers["Email"]?.text,
      );
      showError = false;
      loading = false;
      allowEdit = false;
      showSuccesful = true;
      notifyListeners();
    } catch (e) {
      print(e);
      showError = true;
      allowEdit = true;
      loading = false;
      notifyListeners();
    }
  }
}
