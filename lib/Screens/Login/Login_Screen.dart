import 'package:aeavyactual/Screens/Regestration/Regestration_Welcome_Screen.dart';

import '../../Cusom_Loader.dart';
import 'Login_Screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginScreenFun(), child: LoginScreenWidgets());
  }
}

class LoginScreenWidgets extends StatelessWidget {
  const LoginScreenWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aeavy Seller",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Flexible(
                      child: Text("Welcome to ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 18, fontFamily: "Varela")),
                    ),
                    Text(
                      "Aeavy Seller Platform",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "Varela"),
                    ),
                  ]),
                  Text(
                    "The easiest and clean way of selling branded products online",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 18, height: 1.2, fontFamily: "Varela"),
                  ),
                  SizedBox(height: 18),
                  Text("Please enter your registered number",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginPageNumberField(
                      Provider.of<LoginScreenFun>(context, listen: false)
                          .textEditingController),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Consumer<LoginScreenFun>(
                          builder: (context, loginScreenFun, child) => Text(
                                loginScreenFun.showError
                                    ? loginScreenFun.error
                                    : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: Colors.red),
                              )),
                      Consumer<LoginScreenFun>(
                          builder: (context, loginScreenFun, child) => Text(
                                loginScreenFun.status ? "TRUE" : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: Colors.green),
                              ))
                    ],
                  ),
                ],
              ),
              Consumer<LoginScreenFun>(
                builder: (context, loginScreenFun, child) =>
                    (loginScreenFun.showLoader)
                        ? NeumorphicProgressIndeterminate(
                            style: ProgressStyle(
                                accent: Colors.black, variant: Colors.black),
                            reverse: true,
                            duration: Duration(seconds: 1),
                          )
                        : Container(
                            height: 10,
                          ),
              ),
              SizedBox(height: 14),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 15, height: 1.2, fontFamily: "Varela"),
                    children: [
                      TextSpan(
                          text:
                              "By clicking on \"Agree and Continue\" Button you agree with our "),
                      TextSpan(
                        text: "Terms and Conditions",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 1.2,
                            fontFamily: "Varela"),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 1.2,
                            fontFamily: "Varela"),
                      ),
                    ]),
              ),
              const SizedBox(height: 10),
              NeumorphicButton(
                provideHapticFeedback: true,
                onPressed: () =>
                    Provider.of<LoginScreenFun>(context, listen: false)
                        .sendOTP(context),
                style: NeumorphicStyle(
                  color: Colors.grey.withOpacity(0.1),
                  depth: 5,
                ),
                child: Text(
                  "Agree and Continue",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.black.withOpacity(0.75)),
                ),
              ),
              InkWell(
                  child: Text("Skip", style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegestrationWelcomeScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class AeavyCustomLoader extends StatefulWidget {
  const AeavyCustomLoader({Key? key}) : super(key: key);

  @override
  _AeavyCustomLoaderState createState() => _AeavyCustomLoaderState();
}

class _AeavyCustomLoaderState extends State<AeavyCustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoader(-5),
          const SizedBox(width: 10),
          CustomLoader(-2),
          const SizedBox(width: 10),
          CustomLoader(1),
        ],
      ),
    );
  }
}

class LoginPageNumberField extends StatelessWidget {
  const LoginPageNumberField(
    this.controller, {
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            "+91 ",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Colors.black.withOpacity(0.5)),
          ),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: controller,
              cursorColor: Colors.black,
              cursorRadius: Radius.circular(10),
              style: Theme.of(context).textTheme.headline1,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
