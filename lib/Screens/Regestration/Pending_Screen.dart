import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Regestration/Pending_Screen_Functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PendingScreenFunctions>(
        create: (context) => PendingScreenFunctions(
            Provider.of<UserInformation>(context, listen: false).id),
        child: PendingScreenmainWidgets());
  }
}

class PendingScreenmainWidgets extends StatelessWidget {
  const PendingScreenmainWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PendingScreenFunctions>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FittedBox(
                    child: Text(
                      "Aeavy Seller Account\nVerification Pending",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your Request for Seller Account is being processed. We will notify you when your Account gets verified.",
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "Our executive will contact you for verification purpose.",
                    textAlign: TextAlign.justify,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  PendingScreenWidgets(
                    backgroundColor: Colors.green,
                    iconData: Icons.done,
                    title: "Business Details Submitted",
                  ),
                  PendingScreenWidgets(
                    backgroundColor: Colors.green,
                    iconData: Icons.done,
                    title: "TAX Details Submitted",
                  ),
                  PendingScreenWidgets(
                    backgroundColor: (provider.showAddbankDetails)
                        ? Colors.green
                        : Colors.amber,
                    iconData: (provider.showAddbankDetails)
                        ? Icons.done
                        : Icons.pending_actions_rounded,
                    title: (provider.showAddbankDetails)
                        ? "Account Verified"
                        : "Account Verification Pending",
                  ),
                  PendingScreenWidgets(
                    backgroundColor: Colors.amber,
                    iconData: (provider.showAddbankDetails)
                        ? Icons.pending_actions_rounded
                        : Icons.watch_later,
                    title: (provider.showAddbankDetails)
                        ? "Add Bank Details"
                        : "Next Bank Details",
                  ),
                  SizedBox(height: 10),
                  if (!provider.showAddbankDetails)
                    Row(
                      children: [
                        NeumorphicButton(
                          onPressed: (provider.showLoading)
                              ? null
                              : provider.checkStatus,
                          child: (provider.showLoading)
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ))
                              : Row(
                                  children: [
                                    Icon(Icons.refresh, color: Colors.black),
                                    Text("Refresh",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(fontSize: 16))
                                  ],
                                ),
                        ),
                      ],
                    ),
                  if(provider.showAddbankDetails)
                    Row(
                      children: [
                        NeumorphicButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.account_balance, color: Colors.green),
                              Text(
                                "Add Bank Details",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontSize: 16, color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ))),
    );
  }
}

class PendingScreenWidgets extends StatelessWidget {
  const PendingScreenWidgets({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.iconData,
  }) : super(key: key);
  final String title;
  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            maxRadius: 16,
            child: Icon(iconData),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }
}
