import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:provider/provider.dart';

import '/Screens/Profile%20Screen/Profile_Screen.dart';
import 'package:aeavyactual/Screens/Settings/Settings_Screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: mediaQuery.height,
      width: mediaQuery.width * 0.65,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserDetailsInDrawer(
                  businessName:
                      Provider.of<UserInformation>(context).businessName),
              const SizedBox(height: 10),
              HomeScreenDrawerWidget(
                title: "Profile Details",
                icon: Icons.person,
                callBack: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileDetailsScreen())),
              ),
              HomeScreenDrawerWidget(
                  title: "Orders", icon: Icons.online_prediction_rounded),
              HomeScreenDrawerWidget(
                  title: "Statistics", icon: Icons.speed_rounded),
              Divider(
                color: Colors.black.withOpacity(0.6),
              ),
              HomeScreenDrawerWidget2(title: "Contact Us"),
              HomeScreenDrawerWidget2(
                title: "Settings",
                callBack: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserDetailsInDrawer extends StatelessWidget {
  const UserDetailsInDrawer({
    required this.businessName,
    Key? key,
  }) : super(key: key);
  final String businessName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4)),
      child: SafeArea(
          child: Column(
        children: [
          ClipOval(
            child: Container(
              height: 100,
              width: 100,
              child: CachedNetworkImage(
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQocM0KGQaykKbxv3JmgFDLBwPJ9Nf0Nmvcx6P8oz8RftolDFFFe-6_aL6nddbgoCShN3U&usqp=CAU",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            businessName,
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}

class HomeScreenDrawerWidget2 extends StatelessWidget {
  const HomeScreenDrawerWidget2({
    required this.title,
    this.callBack,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback? callBack;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

class HomeScreenDrawerWidget extends StatelessWidget {
  const HomeScreenDrawerWidget({
    required this.title,
    this.callBack,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback? callBack;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicButton(
        child: Row(
          children: [
            Icon(
              icon,
              size: 26,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
        onPressed: callBack ?? () {},
      ),
    );
  }
}
