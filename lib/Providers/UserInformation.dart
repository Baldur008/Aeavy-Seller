import 'package:aeavyactual/SharedPreferences.dart';
import 'package:flutter/foundation.dart';

class UserInformation with ChangeNotifier {
  String phoneNumber;
  String businessName;
  String sellerName;
  String contactPersonName;
  String email;
   String id;

  UserInformation({
    required this.businessName,
    required this.phoneNumber,
    required this.sellerName,
    required this.contactPersonName,
    required this.email,
    required this.id,
  });

  updateDataBase({
    required businessName,
    required phoneNumber,
    required sellerName,
    required contactPersonName,
    required email,
  }) async {
    print(businessName);
    print(phoneNumber);
    print(sellerName);
    print(contactPersonName);
    print(email);
    this.businessName = businessName;
    this.phoneNumber = phoneNumber;
    this.sellerName = sellerName;
    this.contactPersonName = contactPersonName;
    this.email = email;
    bool value;
    value = await SingleTon().setStringValue("businessName", businessName);
    value = await SingleTon().setStringValue("sellerName", sellerName);
    value = await SingleTon().setStringValue("phoneNumber", phoneNumber);
    value = await SingleTon()
        .setStringValue("contactPersonName", contactPersonName);
    value = await SingleTon().setStringValue("email", email);
    if (!value) throw "Error in updating DATABASE";
    print(SingleTon().getStringValue("businessName"));
    print(SingleTon().getStringValue("sellerName"));
    print(SingleTon().getStringValue("phoneNumber"));
    print(SingleTon().getStringValue("contactPersonName"));
    print(SingleTon().getStringValue("email"));
  }
}
