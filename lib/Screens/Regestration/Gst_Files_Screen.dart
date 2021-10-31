import 'package:aeavyactual/Screens/Regestration/BusinessDetails_Screen.dart';
import 'package:aeavyactual/Screens/Regestration/Regestration_Screen_Functions.dart';
import 'package:aeavyactual/Screens/Regestration/Review_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class RegestrationScreen3 extends StatelessWidget {
  const RegestrationScreen3({Key? key}) : super(key: key);

  nextpage(context, value) {
    Provider.of<RegestrationScreenFunctions>(context, listen: false)
        .declaredValidinformation = false;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<RegestrationScreenFunctions>.value(
                    value: value,
                    builder: (context, child) => ReviewScreen())));
  }

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
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    Spacer(),
                    Text("TAX Details",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontSize: 22,
                            )),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20),
                RegTextField(
                  title: "GSTIN",
                  fieldName: "GSTIN",
                  isLastField: true,
                  hintText: "Enter GST invoice",
                ),
                Consumer<RegestrationScreenFunctions>(
                  builder: (context, regScreenFun, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FileUploadWidget(
                        title: "GST Certificate",
                        path: regScreenFun.gstFileName ?? "No File Uploaded",
                        uploadFileFunction: () =>
                            provider.locateFile(forTradeLicense: false),
                      ),
                      if (!regScreenFun.fieldEntered["GSTFilePath"]!)
                        Text(
                          "Please upload file",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Consumer<RegestrationScreenFunctions>(
                  builder: (context, regScreenFun, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FileUploadWidget(
                        title: "Trade License/Registration Certificate",
                        path: regScreenFun.tradeLicensceFileName ??
                            "No File Uploaded",
                        uploadFileFunction: () =>
                            provider.locateFile(forTradeLicense: true),
                      ),
                      if (!regScreenFun.fieldEntered["TradeLicenseFilePath"]!)
                        Text(
                          "Please upload file",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                      child: Text(
                        "Save & Review",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      provideHapticFeedback: true,
                      onPressed: () => provider.taxDetailsCompleted(
                          context, provider, nextpage),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({
    Key? key,
    required this.uploadFileFunction,
    required this.title,
    required this.path,
  }) : super(key: key);

  final VoidCallback uploadFileFunction;
  final String title;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(path),
            ),
            NeumorphicButton(
              onPressed: uploadFileFunction,
              provideHapticFeedback: true,
              child: Text(
                "Upload",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
          ],
        ),
      ],
    );
  }
}
