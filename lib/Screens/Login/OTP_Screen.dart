import 'dart:async';

import 'package:aeavyactual/Screens/Login/Login_Screen.dart';

import '../../Providers/UserInformation.dart';

import 'OTP_Screen_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OTPScreenFun(),
      child: OTPScreenWidgets(),
    );
  }
}

class OTPScreenWidgets extends StatelessWidget {
  const OTPScreenWidgets({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter the otp",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 8,
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                      TextSpan(
                          text:
                              "A 6 digit OTP has been sent to the number\n+91-${Provider.of<UserInformation>(context).phoneNumber} "),
                      TextSpan(
                          text: "change number\n\n",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Provider.of<OTPScreenFun>(context, listen: false)
                                  .stopTimer();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Can't recive OTP? "),
                      TextSpan(
                          text: "help",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold))
                    ])),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Clear OTP",
                            recognizer: TapGestureRecognizer()
                              ..onTap = Provider.of<OTPScreenFun>(context,
                                      listen: false)
                                  .clearOTP,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller:
                          Provider.of<OTPScreenFun>(context, listen: false)
                              .textEditingController,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      cursorColor: Colors.black,
                      cursorRadius: Radius.circular(10),
                      style: Theme.of(context).textTheme.headline1,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<OTPScreenFun>(
                        builder: (context, otpScreenFun, child) => Text(
                              (otpScreenFun.status)
                                  ? "VERIFICATION SUCCESS"
                                  : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.green),
                            )),
                    Consumer<OTPScreenFun>(
                        builder: (context, otpScreenFun, child) => Text(
                              (otpScreenFun.showError)
                                  ? otpScreenFun.error
                                  : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.red),
                            )),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<OTPScreenFun>(
                  builder: (context, otpScreenFun, child) =>
                      (otpScreenFun.showLoader)
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
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<OTPScreenFun>(
                        builder: (context, otpscreenfun, child) {
                      if (otpscreenfun.showResendOTPButton)
                        return InkWell(
                          onTap: () => otpscreenfun.resendOTP(context),
                          child: Text(
                            "Resend OTP",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      return Column(
                        children: [
                          if (otpscreenfun.otpResent)
                            Text("OTP Resent succesful",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.green)),
                          Text("Resend OTP in " +
                              otpscreenfun.resendOTPSeconds.toString() +
                              " seconds"),
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                NeumorphicButton(
                  provideHapticFeedback: true,
                  onPressed: () =>
                      Provider.of<OTPScreenFun>(context, listen: false)
                          .verifyOTPFormat(context),
                  style: NeumorphicStyle(
                    color: Colors.grey.withOpacity(0.1),
                    depth: 5,
                  ),
                  child: Text(
                    "Verify OTP and Continue",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.black.withOpacity(0.75)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class OTPResend extends StatefulWidget {
  const OTPResend({required this.callBack, required this.seconds, Key? key})
      : super(key: key);
  final VoidCallback callBack;
  final int seconds;
  @override
  _OTPResendState createState() => _OTPResendState();
}

class _OTPResendState extends State<OTPResend> {
  late Timer timer;
  int seconds = 5;
  @override
  void initState() {
    seconds = widget.seconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds = seconds - 1;
      if (timer.isActive) setState(() {});
      if (seconds == 0) {
        this.timer.cancel();
        widget.callBack();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2,
                children: [
              TextSpan(text: "Resend OTP in "),
              TextSpan(
                text: seconds.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " seconds"),
            ])),
      ],
    );
  }
}
