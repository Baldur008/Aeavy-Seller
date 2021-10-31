import 'package:aeavyactual/Screens/Login/Login_Screen.dart';
import 'package:aeavyactual/SharedPreferences.dart';

import 'Settings_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsScreenFuncitons>(
      create: (context) => SettingsScreenFuncitons(),
      child: SettingsScreenWidgets(),
    );
  }
}

class SettingsScreenWidgets extends StatelessWidget {
  const SettingsScreenWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(color: Colors.black.withOpacity(0.5)),
              InkWell(
                onTap: () {
                  SingleTon().setLogin(false);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Log Out",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
