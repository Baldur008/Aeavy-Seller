import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Regestration/BusinessDetails_Screen.dart';
import 'package:aeavyactual/Screens/Regestration/Regestration_Screen_Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class RegestrationScreen extends StatelessWidget {
  const RegestrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegestrationScreenFunctions(
          Provider.of<UserInformation>(context, listen: false).updateDataBase),
      child: RegestrationScreenWidgets(),
    );
  }
}

class RegestrationScreenWidgets extends StatelessWidget {
  const RegestrationScreenWidgets({
    Key? key,
  }) : super(key: key);

  nextPage(context, value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChangeNotifierProvider<RegestrationScreenFunctions>.value(
                value: value,
                builder: (context, child) => RegestrationScreen2())));
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
                Text(
                  "Seller Account Registeration",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  "Create your seller account by filling the form and submitting it",
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
                RegTextField(
                  title: "Owner Name",
                  fieldName: "OwnerName",
                ),
                RegTextField(
                  title: "Registered Phone Number",
                  editable: false,
                  isNumber: true,
                  data: Provider.of<UserInformation>(context).phoneNumber,
                ),
                RegTextField(
                  title: "Contact Email",
                  fieldName: "Email",
                  isLastField: true,
                  hintText: "email@company.org",
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
                      onPressed: () => provider.personalDetailsCompleted(
                          context, provider, nextPage),
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
