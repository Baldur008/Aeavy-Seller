import 'package:aeavyactual/Products%20Screen/Products_Screen.dart';

import 'Sub_Categories_Screen_Functions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen(
      {required this.categoryId, required this.brandName, Key? key})
      : super(key: key);
  final String categoryId;
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubCategoriesFunctions>(
      create: (context) => SubCategoriesFunctions(categoryId),
      child: SubCategoriesScreenWidgets(brandName),
    );
  }
}

class SubCategoriesScreenWidgets extends StatelessWidget {
  const SubCategoriesScreenWidgets(this.brandName, {Key? key})
      : super(key: key);
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          brandName,
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Consumer<SubCategoriesFunctions>(
          builder: (context, subcateFun, child) {
        if (subcateFun.showError)
          return Center(
              child: Text(
            "UnKnown Error Occured",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.red),
          ));
        if (subcateFun.showLoading)
          return Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));

        if (subcateFun.subCategories.isEmpty)
          return Center(
              child: Text("Can't find sub-categories",
                  style: Theme.of(context).textTheme.bodyText1));
        return Column(
          children: subcateFun.subCategories
              .map<Widget>((e) => InkWell(
                overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.3)),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductScreen(
                            subCategoryId: e["_id"], brandName: brandName))),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            e["sub_category_name"].toString().trim(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        );
      }),
    );
  }
}
