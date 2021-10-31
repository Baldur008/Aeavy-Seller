import 'package:aeavyactual/Home%20Screen/Home_Screen.dart';
import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:aeavyactual/Screens/Login/OTP_Screen.dart';
import 'package:aeavyactual/Screens/Regestration/Pending_Screen.dart';
import 'package:aeavyactual/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Login/Login_Screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SingleTon().initialize();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInformation>(
            create: (context) => UserInformation(
                businessName: SingleTon().getStringValue("businessName"),
                phoneNumber: SingleTon().getStringValue("phoneNumber"),
                sellerName: SingleTon().getStringValue("sellerName"),
                id: SingleTon().getStringValue("_id"),
                contactPersonName:
                    SingleTon().getStringValue("contactPersonName"),
                email: SingleTon().getStringValue("email"))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            primaryColor: Colors.black,
            splashColor: Colors.black,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                foregroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black)),
            scaffoldBackgroundColor: Color(0xFFDDE6E8),
            iconTheme: IconThemeData(
              color: Color(0xFFDDE6E8),
            ),
            fontFamily: "Ubuntu",
            textTheme: TextTheme(
              bodyText2: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 0.3,
              ),
              bodyText1: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7),
                letterSpacing: 0.3,
              ),
              headline6: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              caption: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.5),
              ),
              headline1: TextStyle(
                fontSize: 24,
                color: Colors.black,
                letterSpacing: 0.6,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                  fontFamily: "Varela",
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black),
              headline3: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Varela"),
              button: TextStyle(
                fontSize: 16,

                color: Colors.black,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            )),
        // home: LoginScreen(),
        home: SingleTon().isLoggedIn()
            ? HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}
