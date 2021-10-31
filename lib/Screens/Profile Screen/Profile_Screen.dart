import 'package:aeavyactual/Screens/Profile%20Screen/Details_Edit_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Details",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ClipOval(
              //       child: Container(
              //         height: 100,
              //         width: 100,
              //         constraints: BoxConstraints(maxWidth: 100),
              //         child: CachedNetworkImage(
              //           imageUrl:
              //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQocM0KGQaykKbxv3JmgFDLBwPJ9Nf0Nmvcx6P8oz8RftolDFFFe-6_aL6nddbgoCShN3U&usqp=CAU",
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              ProfileDetailsScreenButton(
                "Business Details",
                page: DetailsEditScreen(),
              ),
              ProfileDetailsScreenButton(
                "Bank Details",
                keys: [
                  ["Account Name", "account_name"],
                  ["Account Name", "confirm_account_number"],
                  ["Account Name", "account_number"],
                  ["Account Name", "bank_name"],
                  ["Account Name", "ifsc_code"],
                  ["Account Name", "ifsc_code"],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailsScreenButton extends StatelessWidget {
  const ProfileDetailsScreenButton(
    this.title, {
      this.page,
    this.keys = const [],
    Key? key,
  }) : super(key: key);
  final String title;
  final List keys;
  final page;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: NeumorphicButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => page)),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17),
            ),
            const Icon(
              Icons.library_books,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
