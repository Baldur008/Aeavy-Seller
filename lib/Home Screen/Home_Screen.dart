import 'package:aeavyactual/Categories%20Screen/Category_Screen.dart';
import 'package:aeavyactual/Home%20Screen/Home_Screen_Functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'Home_Screen_Drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenFunctions(),
      child: HomeScreenWidgets(),
    );
  }
}

class HomeScreenWidgets extends StatelessWidget {
  HomeScreenWidgets({
    Key? key,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  openEndDrawer() => scaffoldKey.currentState?.openEndDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: HomeScreenDrawer(),
      body: Column(
        children: [
          HomeScreenAppBar(openEndDrawer),
          Expanded(
            child: Consumer<HomeScreenFunctions>(
                builder: (context, homeScreenFun, child) {
              if (homeScreenFun.showError)
                return Center(
                    child: Text(
                  "UnKnown Error Occured",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.red),
                ));
              if (homeScreenFun.showLoadingBrands)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));

              if (homeScreenFun.brands.isEmpty)
                return Center(
                    child: Text("Can't find products in this sub category",
                        style: Theme.of(context).textTheme.bodyText1));
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  children: homeScreenFun.brands
                      .map(
                        (brand) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategoryScreen(
                                      brandId: brand["_id"] ?? "",
                                      brandName: brand["trademark_name"] ?? "",
                                    )));
                          },
                          child: BrandViewerWidget(
                            brandName: brand["trademark_name"] ?? "",
                            imageUrl: brand["brand_logo"] ?? "",
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class BrandViewerWidget extends StatelessWidget {
  const BrandViewerWidget({
    Key? key,
    required this.imageUrl,
    required this.brandName,
  }) : super(key: key);
  final String imageUrl;
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: (imageUrl == "")
                  ? "http://via.placeholder.com/350x150"
                  : imageUrl,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            brandName,
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar(this.callback, {Key? key}) : super(key: key);
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.black,
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/v2.png"))),
            ),
            InkWell(
                onTap: callback,
                child: Icon(
                  Icons.menu,
                  size: 28,
                )),
          ],
        ),
      )),
    );
  }
}
