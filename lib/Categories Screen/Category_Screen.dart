import 'package:aeavyactual/Sub%20Categories%20Screen/Sub_Categories_Screen.dart';

import 'Category_Screen_Functions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {Key? key, required this.brandId, required this.brandName})
      : super(key: key);
  final String brandId;
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryScreenFunctions>(
      create: (context) => CategoryScreenFunctions(brandId),
      child: CategoryScreenWidgets(brandName),
    );
  }
}

class CategoryScreenWidgets extends StatelessWidget {
  const CategoryScreenWidgets(
    this.brandName, {
    Key? key,
  }) : super(key: key);
  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(brandName, style: Theme.of(context).textTheme.headline3),
      ),
      body: Consumer<CategoryScreenFunctions>(
          builder: (context, catScreenFun, child) {
        if (catScreenFun.showError)
          return Center(
              child: Text(
            "UnKnown Error Occured",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.red),
          ));
        if (catScreenFun.showLoading)
          return Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));

        if (catScreenFun.categories.isEmpty)
          return Center(
              child: Text("Can't find categories",
                  style: Theme.of(context).textTheme.bodyText1));
        return SingleChildScrollView(
          child: Column(
              children: catScreenFun.categories
                  .map<Widget>((value) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SubCategoriesScreen(
                                  categoryId: value["_id"],
                                  brandName: brandName,
                                )));
                      },
                      child: CategoriesScreenWidgets(value)))
                  .toList()),
        );
      }),
    );
  }
}

class CategoriesScreenWidgets extends StatelessWidget {
  const CategoriesScreenWidgets(this.value, {Key? key}) : super(key: key);
  final Map value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (value["category_logo"] == "")
                    ? AssetImage("assets/images/f2.png")
                    : NetworkImage(value["category_logo"]) as ImageProvider,
              ),
            ),
          ),
          Text(
            value["category_name"].toString(),
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
