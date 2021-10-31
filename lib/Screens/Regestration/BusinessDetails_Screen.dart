import 'package:aeavyactual/Screens/Regestration/Gst_Files_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'Regestration_Screen_Functions.dart';

class RegestrationScreen2 extends StatelessWidget {
  const RegestrationScreen2({Key? key}) : super(key: key);

  nextPage(context, value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChangeNotifierProvider<RegestrationScreenFunctions>.value(
                value: value,
                builder: (context, child) => RegestrationScreen3())));
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
                    Text("Business Details",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontSize: 22,
                            )),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                RegTextField(
                  title: "Business Name",
                  fieldName: "BusinessName",
                ),
                RegTextField(
                  title: "Contact Person Name",
                  fieldName: "ContactPersonName",
                ),
                RegTextField(
                  title: "Contact Person Number",
                  isNumber: true,
                  fieldName: "ContactNumber",
                ),
                SelectCityWidget(),
                RegTextField(
                  title: "Address",
                  maxLines: 5,
                  fieldName: "BusinessAddress",
                ),
                RegTextField(
                  title: "Pincode",
                  fieldName: "BusinessPinCode",
                  isJustNumber: true,
                  isLastField: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                      child: Text(
                        "Save & Next",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      provideHapticFeedback: true,
                      onPressed: () => provider.businessDetailsCompleted(
                          context, provider, nextPage),
                    ),
                  ],
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Select City", style: Theme.of(context).textTheme.headline3),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            InkWell(
              child: Neumorphic(
                padding: EdgeInsets.all(8),
                style: NeumorphicStyle(
                    border: NeumorphicBorder(
                  color: Colors.black,
                  width: 2,
                )),
                child:
                    Text("Delhi", style: Theme.of(context).textTheme.headline3),
              ),
            ),
          ],
        ),
        SizedBox(height: 20)
      ],
    );
  }
}

class RegTextField extends StatelessWidget {
  const RegTextField({
    required this.title,
    this.fieldName = "1234",
    this.validationRequired = true,
    this.editable = true,
    this.maxLines = 1,
    this.isNumber = false,
    this.isJustNumber = false,
    this.isLastField = false,
    this.data,
    this.hintText,
    this.showError = true,
    this.errorText,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool editable;
  final String? data;
  final int? maxLines;
  final String? hintText;
  final bool validationRequired;
  final bool showError;
  final String fieldName;
  final String? errorText;
  final bool isNumber;
  final bool isJustNumber;
  final bool isLastField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 8),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1.4),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              if (isNumber)
                Text(
                  "+91 ",
                  style: Theme.of(context).textTheme.headline3,
                ),
              Expanded(
                child: TextField(
                  maxLines: maxLines,
                  keyboardType:
                      (isNumber || isJustNumber) ? TextInputType.phone : null,
                  textInputAction: (isLastField)
                      ? TextInputAction.done
                      : TextInputAction.next,
                  cursorColor: Colors.black,
                  style: Theme.of(context).textTheme.headline3,
                  controller: Provider.of<RegestrationScreenFunctions>(context)
                          .fieldController[this.fieldName] ??
                      TextEditingController(text: data),
                  inputFormatters: [
                    if (isNumber || isJustNumber)
                      FilteringTextInputFormatter.digitsOnly,
                    if (isNumber) LengthLimitingTextInputFormatter(10),
                    if (isJustNumber) LengthLimitingTextInputFormatter(6),
                  ],
                  enabled: editable,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.headline3?.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (validationRequired)
          Consumer<RegestrationScreenFunctions>(
            builder: (context, regScreenFun, child) =>
                (regScreenFun.fieldEntered[this.fieldName] ?? true)
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Please fill this field",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
          ),
        SizedBox(height: 14),
      ],
    );
  }
}
