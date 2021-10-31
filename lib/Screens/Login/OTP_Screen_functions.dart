import 'dart:async';
import 'dart:convert';

import 'package:aeavyactual/Home%20Screen/Home_Screen.dart';
import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Regestration/Regestration_Welcome_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../SharedPreferences.dart';

class OTPScreenFun with ChangeNotifier {
  OTPScreenFun() {
    resendOTPButtonEnabler();
  }
  bool showLoader = false;
  bool showError = false;
  bool status = false;
  String error = "";
  bool sentRequest = false;
  bool showResendOTPButton = false;
  bool otpResent = false;
  int resendOTPSeconds = 59;

  TextEditingController textEditingController = TextEditingController();
  late Timer timer;
  clearOTP() {
    for (int i = 0; i < 6; ++i) textEditingController.text = "";
  }

  stopTimer() => timer.cancel();

  resendOTP(context) async {
    try {
      otpResent = false;
      notifyListeners();
      Response value = await post(
          Uri.parse(r"https://brands.aeavy.com/api/v1/login/phone"),
          body: {
            "phone":
                Provider.of<UserInformation>(context, listen: false).phoneNumber
          });
      var response = json.decode(value.body) as Map;
      if (response['status']) {
        otpResent = true;
        print(response);
        resendOTPButtonEnabler();
      } else {
        resendOTP(context);
      }
    } catch (e) {
      print(e);
      showError = true;
      error = "Unable to request OTP. Please try again";
      notifyListeners();
    }
  }

  resendOTPButtonEnabler() {
    showResendOTPButton = false;
    resendOTPSeconds = 59;
    this.timer = Timer.periodic(Duration(seconds: 1), (insidetimer) {
      resendOTPSeconds--;
      if (resendOTPSeconds == 0) {
        otpResent = false;
        showResendOTPButton = true;
        notifyListeners();
        this.timer.cancel();
        return;
      }
      notifyListeners();
    });
  }

  verifyOTPFormat(BuildContext context) {
    String otp = textEditingController.text;
    if (otp.length < 6) {
      showError = true;
      error = "Invalid OTP";
      notifyListeners();
      return;
    }
    showError = false;
    showLoader = true;
    notifyListeners();
    if (!sentRequest) sendRequest(otp, context);
  }

  sendRequest(otp, context) async {
    try {
      sentRequest = true;
      Response value = await post(
          Uri.parse(r"https://brands.aeavy.com/api/v1/login/verify"),
          body: {
            "phone": Provider.of<UserInformation>(context, listen: false)
                .phoneNumber,
            "otp": otp,
          });

      var response = json.decode(value.body) as Map;
      print(response);

      if (response['status']) {
        status = true;
        await SingleTon().setLogin(true);
        SingleTon().setStringValue("phoneNumber",
            Provider.of<UserInformation>(context, listen: false).phoneNumber);
        timer.cancel();
        var value = response["data"];
        if (value == null)
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RegestrationWelcomeScreen()));
        else
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showError = true;
        error = "Please check your otp";
      }
      showLoader = false;
      sentRequest = false;
      notifyListeners();
    } catch (e) {
      showError = true;
      error = "Please try again";
      showLoader = false;
      sentRequest = false;
      notifyListeners();
    }
  }
}
