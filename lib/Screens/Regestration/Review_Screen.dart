import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Regestration/Uploading_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'Regestration_Screen_Functions.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<RegestrationScreenFunctions>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Review your details",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  "Please check whether the data is correct, to edit details go back and edit",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 20),
                Text("Personal Details",
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: 22,
                        )),
                SizedBox(height: 20),
                ReviewWidgets(
                  title: "Owner Name",
                  data: provider.fieldController["OwnerName"]!.text,
                ),
                ReviewWidgets(
                  title: "Registered Number",
                  data:
                      "+91 ${Provider.of<UserInformation>(context).phoneNumber}",
                ),
                ReviewWidgets(
                  title: "Email",
                  data: provider.fieldController["Email"]!.text,
                ),
                Divider(color: Colors.black.withOpacity(0.7)),
                SizedBox(height: 20),
                Text("Business Details",
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: 22,
                        )),
                SizedBox(height: 20),
                ReviewWidgets(
                  title: "Business Name",
                  data: provider.fieldController["BusinessName"]!.text,
                ),
                ReviewWidgets(
                  title: "Contact Person Name",
                  data: provider.fieldController["ContactPersonName"]!.text,
                ),
                ReviewWidgets(
                  title: "Contact Person Number",
                  data:
                      "+91 " + provider.fieldController["ContactNumber"]!.text,
                ),
                ReviewWidgets(
                  title: "City",
                  data: "Delhi",
                ),
                ReviewWidgets(
                  title: "Address",
                  data: provider.fieldController["BusinessAddress"]!.text,
                ),
                ReviewWidgets(
                  title: "Pincode",
                  data: provider.fieldController["BusinessPinCode"]!.text,
                ),
                Divider(color: Colors.black.withOpacity(0.7)),
                SizedBox(height: 20),
                Text("TAX Details",
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontSize: 22,
                        )),
                SizedBox(height: 20),
                ReviewWidgets(
                  title: "GSTIN",
                  data: provider.fieldController["GSTIN"]!.text,
                ),
                ReviewWidgets(
                  title: "GST Certificate",
                  data: provider.gstFileName ?? "No File Uploaded",
                ),
                ReviewWidgets(
                  title: "Trade License/Registration Certificate",
                  data: provider.tradeLicensceFileName ?? "No File Uploaded",
                ),
                Divider(color: Colors.black.withOpacity(0.7)),
                SizedBox(height: 20),
                Consumer<RegestrationScreenFunctions>(
                  builder: (context, regScreenFun, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NeumorphicCheckbox(
                            value: regScreenFun.declaredValidinformation,
                            onChanged: (value) {
                              regScreenFun.declarevalidInformationToggle();
                            },
                            padding: EdgeInsets.all(3),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                              child: Text(
                            "I delcare that the above data is correct and valid",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.black, fontSize: 17),
                          )),
                        ],
                      ),
                      SizedBox(height: 20),
                      NeumorphicButton(
                        duration: Duration(milliseconds: 200),
                        provideHapticFeedback: true,
                        child: Text(
                          "Submit for verification",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        onPressed: regScreenFun.declaredValidinformation
                            ? () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider<RegestrationScreenFunctions>.value(
                                                value: provider,
                                                builder: (context, child) =>
                                                    UploadingFilesScreen())));
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewWidgets extends StatelessWidget {
  const ReviewWidgets({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: Theme.of(context).textTheme.headline3),
          ),
          Expanded(
            flex: 3,
            child: Text(data,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.black.withOpacity(0.7))),
          )
        ],
      ),
    );
  }
}
