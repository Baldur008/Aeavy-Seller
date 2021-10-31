import 'package:aeavyactual/Screens/Regestration/Pending_Screen.dart';
import 'package:aeavyactual/Screens/Regestration/Regestration_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RegestrationWelcomeScreen extends StatelessWidget {
  const RegestrationWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Namasthe",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Flexible(
                    child: Text("Welcome to ",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 18, fontFamily: "Varela", height: 1.1)),
                  ),
                  Text("Aeavy Seller Platform.",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "Varela",
                          height: 1.1)),
                ]),
                SizedBox(height: 10),
                Text(
                  "Before joining Aeavy as a seller we require few details for verification purpose",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 18, height: 1.1, fontFamily: "Varela"),
                ),
                SizedBox(height: 18),
                Text(
                  "Required Details",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 26),
                ),
                SizedBox(height: 18),
                regestrationWelcomeScreenWidgets(title: "Business Details"),
                regestrationWelcomeScreenWidgets(
                    title: "GST Certificate Upload\n(PDF, JPEG, PNG)",
                    iconData: Icons.document_scanner_outlined),
                regestrationWelcomeScreenWidgets(
                    title: "Trade License Upload\n(PDF, JPEG, PNG)",
                    iconData: Icons.document_scanner_outlined),
                regestrationWelcomeScreenWidgets(
                  title: "Bank Details",
                  iconData: Icons.account_balance,
                ),
                SizedBox(height: 18),
                NeumorphicButton(
                  provideHapticFeedback: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegestrationScreen()));
                  },
                  child: Text(
                    "Continue for uploading Details",
                    style: Theme.of(context).textTheme.button,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  regestrationWelcomeScreenWidgets({
    required String title,
    IconData iconData = Icons.business,
  }) {
    return PendingScreenWidgets(
        title: title, backgroundColor: Colors.green, iconData: iconData);
  }
}
