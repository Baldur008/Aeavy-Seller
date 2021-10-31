import 'dart:convert';

import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Regestration/Pending_Screen.dart';
import 'package:aeavyactual/SharedPreferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegestrationScreenFunctions with ChangeNotifier {
  RegestrationScreenFunctions(this.callBack);
  final Function callBack;
  Map<String, TextEditingController> fieldController = {
    "OwnerName": TextEditingController(),
    "Email": TextEditingController(),
    "BusinessName": TextEditingController(),
    "ContactPersonName": TextEditingController(),
    "ContactNumber": TextEditingController(),
    "BusinessAddress": TextEditingController(),
    "BusinessPinCode": TextEditingController(),
    "GSTIN": TextEditingController(),
  };

  Map<String, bool> fieldEntered = {
    "OwnerName": true,
    "Email": true,
    "BusinessName": true,
    "ContactPersonName": true,
    "ContactNumber": true,
    "BusinessAddress": true,
    "BusinessPinCode": true,
    "GSTIN": true,
    "GSTFilePath": true,
    "TradeLicenseFilePath": true,
  };

  bool declaredValidinformation = false;
  String? gstFileName;
  String? gstFilePath;
  String? tradeLicensceFileName;
  String? tradeLicensceFilePath;

  bool uploadedGSTFile = false;
  bool uploadedTradeLicenseFile = false;
  bool uploadedDetails = false;
  bool showErrorInUploadScreen = false;

  String? tradeLicensceFileUploadedLocation;
  String? gSTFileUploadedLocation;

  declarevalidInformationToggle() {
    declaredValidinformation = !declaredValidinformation;
    notifyListeners();
  }

  uploadDataToApi(context) async {
    try {
      var provider = Provider.of<UserInformation>(context, listen: false);
      await uploadFilesOnline(
        filePath: gstFilePath!,
        isTrade: false,
        key: "gst_doc",
        url: "https://brands.aeavy.com/api/v1/registration/addgstdoc",
      );
      await uploadFilesOnline(
        filePath: tradeLicensceFilePath!,
        isTrade: true,
        key: "trade_license",
        url: "https://brands.aeavy.com/api/v1/registration/addlicense",
      );
      http.post(Uri.parse("https://brands.aeavy.com/api/v1/registration"),
          body: {
            "city": "Delhi",
            "seller_name": fieldController["OwnerName"]?.text,
            "email": fieldController["Email"]?.text,
            "busniess_name": fieldController["BusinessName"]?.text,
            "gst": gSTFileUploadedLocation,
            "phone": provider.phoneNumber,
            "trade_licence": tradeLicensceFileUploadedLocation,
            "contact_person": fieldController["ContactPersonName"]?.text,
            "status": "pending"
          }).then((value) async {
        var body = json.decode(value.body);
        print(value.body);
        if (body["data"] != null) {
          print("ID IS " + body["data"]["_id"].toString());
          await SingleTon().setStringValue("_id", body["data"]["_id"]);
          provider.id = body["data"]["_id"];
        }
        await provider.updateDataBase(
          businessName: fieldController["BusinessName"]?.text,
          phoneNumber: provider.phoneNumber,
          sellerName: fieldController["OwnerName"]?.text,
          contactPersonName: fieldController["ContactPersonName"]?.text,
          email: fieldController["Email"]?.text,
        );

        if (value.statusCode < 300) {
          uploadedDetails = true;
          notifyListeners();
        } else {
          showErrorInUploadScreen = true;
          notifyListeners();
        }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PendingScreen()),
          (route) => false);
      });
    } catch (e) {
      showErrorInUploadScreen = true;
      uploadDataToApi(context);
      notifyListeners();
    }
  }

  uploadFilesOnline(
      {required String url,
      required String key,
      required String filePath,
      required bool isTrade}) async {
    http.MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(key, filePath));
    http.StreamedResponse response = await request.send();
    if (response.statusCode < 300) {
      print("Status Ok");
      var body = json.decode(await response.stream.bytesToString())
          as Map<String, dynamic>;
      print(body);
      if (isTrade) {
        tradeLicensceFileUploadedLocation = body["Location"] ?? "UnUploaded";
        print(tradeLicensceFileUploadedLocation);
        uploadedTradeLicenseFile = true;
      } else {
        gSTFileUploadedLocation = body["Location"] ?? "UnUploaded";
        print(gSTFileUploadedLocation);
        uploadedGSTFile = true;
      }
      notifyListeners();
    } else {
      showErrorInUploadScreen = true;
      notifyListeners();
      uploadFilesOnline(
          url: url, key: key, filePath: filePath, isTrade: isTrade);
    }
  }

  locateFile({required bool forTradeLicense}) async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result == null) return;
    if (forTradeLicense) {
      tradeLicensceFileName = result.files.first.extension!;
      tradeLicensceFilePath = result.paths.single;
      fieldEntered["TradeLicenseFilePath"] = true;
    } else {
      gstFileName = result.files.first.extension!;
      gstFilePath = result.paths.single;
      fieldEntered["GSTFilePath"] = true;
    }
    notifyListeners();
  }

  personalDetailsCompleted(BuildContext context, dynamic value,
      Function(BuildContext, dynamic) nextPage) {
    bool triggerError = false;
    fieldEntered["OwnerName"] = true;
    fieldEntered["Email"] = true;

    if (fieldController["OwnerName"]!.text.isEmpty) {
      fieldEntered["OwnerName"] = false;
      triggerError = true;
    }
    if (fieldController["Email"]!.text.isEmpty) {
      fieldEntered["Email"] = false;
      triggerError = true;
    }
    notifyListeners();
    if (triggerError) return;
    nextPage(context, value);
  }

  businessDetailsCompleted(BuildContext context, dynamic value,
      Function(BuildContext, dynamic) nextPage) {
    bool triggerError = false;
    fieldEntered["BusinessName"] = true;
    fieldEntered["ContactPersonName"] = true;
    fieldEntered["ContactNumber"] = true;
    fieldEntered["BusinessAddress"] = true;
    fieldEntered["BusinessPinCode"] = true;
    if (fieldController["BusinessName"]!.text.isEmpty) {
      triggerError = true;
      fieldEntered["BusinessName"] = false;
    }
    if (fieldController["ContactPersonName"]!.text.isEmpty) {
      triggerError = true;
      fieldEntered["ContactPersonName"] = false;
    }
    if (fieldController["ContactNumber"]!.text.length < 10) {
      triggerError = true;
      fieldEntered["ContactNumber"] = false;
    }
    if (fieldController["BusinessAddress"]!.text.isEmpty) {
      triggerError = true;
      fieldEntered["BusinessAddress"] = false;
    }
    if (fieldController["BusinessPinCode"]!.text.isEmpty) {
      triggerError = true;
      fieldEntered["BusinessPinCode"] = false;
    }
    notifyListeners();
    if (triggerError) return;
    nextPage(context, value);
  }

  taxDetailsCompleted(BuildContext context, dynamic value,
      Function(BuildContext, dynamic) nextPage) {
    bool triggerError = false;
    fieldEntered["GSTIN"] = true;
    fieldEntered["TradeLicenseFilePath"] = true;
    fieldEntered["GSTFilePath"] = true;

    if (fieldController["GSTIN"]!.text.isEmpty) {
      triggerError = true;
      fieldEntered["GSTIN"] = false;
    }
    if ((tradeLicensceFilePath ?? "").isEmpty) {
      triggerError = true;
      fieldEntered["TradeLicenseFilePath"] = false;
    }
    if ((gstFilePath ?? "").isEmpty) {
      triggerError = true;
      fieldEntered["GSTFilePath"] = false;
    }
    notifyListeners();
    if (triggerError) return;
    nextPage(context, value);
  }
}
