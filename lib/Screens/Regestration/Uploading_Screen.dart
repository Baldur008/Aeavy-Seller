import 'package:aeavyactual/Screens/Regestration/Regestration_Screen_Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class UploadingFilesScreen extends StatelessWidget {
  const UploadingFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<RegestrationScreenFunctions>(context, listen: false)
        .uploadDataToApi(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              "Your files are being uploaded please wait",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 30),
            Consumer<RegestrationScreenFunctions>(
                builder: (context, regScreenFun, child) =>
                    UploadingScreenWidgets(
                      title: "GST Certificate",
                      isUploaded: regScreenFun.uploadedGSTFile,
                      uploadingText: "Uploading",
                    )),
            SizedBox(height: 30),
            Consumer<RegestrationScreenFunctions>(
                builder: (context, regScreenFun, child) =>
                    UploadingScreenWidgets(
                      title: "Trade License/Registration Certificate",
                      isUploaded: regScreenFun.uploadedTradeLicenseFile,
                      uploadingText: "Uploading",
                    )),
            SizedBox(height: 30),
            Consumer<RegestrationScreenFunctions>(
                builder: (context, regScreenFun, child) =>
                    UploadingScreenWidgets(
                      title: "Verification",
                      isUploaded: regScreenFun.uploadedDetails,
                      uploadingText: "Requesting",
                    )),
            Consumer<RegestrationScreenFunctions>(
              builder: (context, regScreenFun, child) => Text(
                regScreenFun.showErrorInUploadScreen
                    ? "Error, trying again to send request"
                    : "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class UploadingScreenWidgets extends StatelessWidget {
  const UploadingScreenWidgets({
    required this.title,
    required this.isUploaded,
    required this.uploadingText,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool isUploaded;
  final String uploadingText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isUploaded) CircularProgressIndicator(color: Colors.black),
        if (isUploaded) Icon(Icons.done, color: Colors.green),
        SizedBox(width: 10),
        Expanded(
          child: Text(((isUploaded) ? "Uploaded" : uploadingText) + " " + title,
              style: Theme.of(context).textTheme.headline3),
        ),
      ],
    );
  }
}
