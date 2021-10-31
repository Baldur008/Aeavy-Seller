import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader(this.depth, {Key? key}) : super(key: key);
  final double depth;
  @override
  CustomLoadergState createState() => CustomLoadergState();
}

class CustomLoadergState extends State<CustomLoader> {
  late double depth;
  bool toInside = true;
  late Timer timer;
  @override
  void initState() {
    depth = widget.depth;
    timer = Timer.periodic(Duration(milliseconds: 45), (timer) {
      if (toInside) {
        depth = depth - 1;
        if (depth < -5) toInside = false;
        if (timer.isActive) setState(() {});
      } else {
        depth = depth + 1;
        if (depth > 5) toInside = true;
        if (timer.isActive) setState(() {});
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
    return Neumorphic(
      child: const SizedBox(
        height: 30,
        width: 30,
      ),
      style:
          NeumorphicStyle(boxShape: NeumorphicBoxShape.circle(), depth: depth),
    );
  }
}
