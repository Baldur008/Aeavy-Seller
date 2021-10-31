import 'dart:convert';

import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'OTP_Screen.dart';

class LoginScreenFun with ChangeNotifier {
  bool showError = false;
  String error = "";
  bool showLoader = false;
  bool status = false;
  TextEditingController textEditingController = TextEditingController();
  bool requestSent = false;

  sendOTP(BuildContext context) async {
    var phoneNumber = textEditingController.text;
    if (phoneNumber.length != 10) {
      showError = true;
      error = "Invalid Number";
      notifyListeners();
      return;
    }

    if (!requestSent) await sendRequest(phoneNumber, context);

    showError = false;
    showLoader = true;
    notifyListeners();
  }

  sendRequest(phoneNumber, context) async {
    try {
      requestSent = true;
      Response value = await post(
          Uri.parse(r"https://brands.aeavy.com/api/v1/login/phone"),
          body: {"phone": phoneNumber});
      var response = json.decode(value.body) as Map;
      requestSent = false;
      showLoader = false;
      notifyListeners();
      if (response['status']) {
        status = true;
        print(response);
        Provider.of<UserInformation>(context, listen: false).phoneNumber =
            phoneNumber;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OTPScreen()));
      } else {
        sendRequest(phoneNumber, context);
      }
    } catch (e) {
      requestSent = false;
      showError = true;
      showLoader = false;

      error = "Unable to request OTP. Please try again";
      notifyListeners();
    }
  }
}
