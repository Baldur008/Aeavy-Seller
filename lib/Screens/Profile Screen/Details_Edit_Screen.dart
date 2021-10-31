import 'package:aeavyactual/Providers/UserInformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'Details_Edit_Screen_Functions.dart';

class DetailsEditScreen extends StatelessWidget {
  const DetailsEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserInformation>(context, listen: false);
    return ChangeNotifierProvider<DetailsEditScreenFunctions>(
        create: (context) => DetailsEditScreenFunctions(
              businessName: provider.businessName,
              sellerName: provider.sellerName,
              phoneNumber: provider.phoneNumber,
              contactPersonName: provider.contactPersonName,
              email: provider.email,
              id: provider.id,
              callBack: provider.updateDataBase,
            ),
        child: DetailsEditScreenWidgets());
  }
}

class DetailsEditScreenWidgets extends StatelessWidget {
  const DetailsEditScreenWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DetailsEditScreenFunctions>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Details",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
        ),
        actions: [
          if (!provider.loading)
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.black,
              onPressed: provider.allowEditToggle,
            ),
          if (provider.loading)
            Container(
              height: 10,
              padding: EdgeInsets.all(10),
              width: 50,
              child: CircularProgressIndicator(color: Colors.black),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (provider.showError)
                  Column(
                    children: [
                      Text("Unexpected Error Please try again",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.red)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                if (provider.showSuccesful)
                  Column(
                    children: [
                      Text("Updated Details Succesfully",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.green)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                DetailsFeidlWidget(
                  provider: provider,
                  title: "Business Name",
                ),
                DetailsFeidlWidget(
                  provider: provider,
                  title: "Seller Name",
                ),
                DetailsFeidlWidget(
                  provider: provider,
                  title: "Contact Person Name",
                ),
                DetailsFeidlWidget(
                  provider: provider,
                  title: "Phone Number",
                  isNumber: true,
                ),
                DetailsFeidlWidget(
                  provider: provider,
                  title: "Email",
                ),
                if (provider.allowEdit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NeumorphicButton(
                        child: Text(
                          "Save Data",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: provider.updateSellerApi,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsFeidlWidget extends StatelessWidget {
  const DetailsFeidlWidget({
    Key? key,
    this.isNumber = false,
    required this.title,
    required this.provider,
  }) : super(key: key);

  final DetailsEditScreenFunctions provider;
  final String title;
  final bool isNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
        ),
        SizedBox(height: 5),
        Container(
          child: TextField(
            keyboardType: (isNumber) ? TextInputType.phone : null,
            enabled: provider.allowEdit,
            controller: provider.textEditingControllers[title],
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10)),
            textInputAction: TextInputAction.next,
          ),
          decoration: BoxDecoration(
              color: (provider.allowEdit) ? Colors.white : Colors.transparent,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
