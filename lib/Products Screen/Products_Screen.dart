import 'package:aeavyactual/Products%20Screen/Products_Screen_Functions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(
      {required this.subCategoryId, required this.brandName, Key? key})
      : super(key: key);
  final String brandName;
  final String subCategoryId;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ProductsScreenFunctions>(
        create: (context) => ProductsScreenFunctions(subCategoryId),
        child: ProductScreenWidgets(brandName),
      );
}

class ProductScreenWidgets extends StatelessWidget {
  const ProductScreenWidgets(this.brandName, {Key? key}) : super(key: key);
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
      body: Consumer<ProductsScreenFunctions>(
        builder: (context, proScreenFun, child) {
          if (proScreenFun.showError)
            return Center(
                child: Text(
              "UnKnown Error Occured",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.red),
            ));
          if (proScreenFun.showLoading)
            return Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));

          if (proScreenFun.products.isEmpty)
            return Center(
                child: Text("Can't find products in this sub category",
                    style: Theme.of(context).textTheme.bodyText1));
          return ListView(
            children: [...proScreenFun.products, 0]
                .map<Widget>((e) => (e != 0)
                    ? ProductWidget(e)
                    : SizedBox(
                        height: 100,
                      ))
                .toList(),
          );
        },
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget(this.value, {Key? key}) : super(key: key);
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage((value["product_images"] ??
                        [
                          "https://media.istockphoto.com/photos/colored-powder-explosion-abstract-closeup-dust-on-backdrop-colorful-picture-id1072093690?k=20&m=1072093690&s=612x612&w=0&h=Ns3WeEm1VrIHhZOmhiGY_fYKvIlbJrVADLqfxyPQVPM="
                        ])[0]))),
          ),
          Text(value["product_name"],
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(fontSize: 22)),
          const SizedBox(height: 10),
          Table(
              children: [
            ["MRP", "mrp"],
            ["Deal Price", "seller_price"],
            ["Retail Sale", "customer_price"]
          ]
                  .map<TableRow>((e) => TableRow(children: [
                        Text(
                          e[0],
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          "₹ " + value[e[1]],
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 23,
                                  ),
                        ),
                      ]))
                  .toList()),
          // ...[
          //   ["MRP", "mrp"],
          //   ["Deal Price", "seller_price"],
          //   ["Retail Sale", "customer_price"]
          // ]
          //     .map<Widget>(
          //       (e) => RichText(
          //           text: TextSpan(
          //               style: Theme.of(context).textTheme.bodyText1?.copyWith(
          //                     fontSize: 18,
          //                   ),
          //               children: [
          //             TextSpan(text: e[0] + ": ₹ "),
          //             TextSpan(
          //               text: value[e[1]],
          //               style: Theme.of(context).textTheme.bodyText1?.copyWith(
          //                     fontSize: 23,
          //                   ),
          //             ),
          //           ])),
          //     )
          //     .toList(),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Quantity",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 18,
                      )),
              SizedBox(width: 10),
              Container(
                width: 60,
                child: TextField(
                    cursorColor: Colors.black,
                    cursorHeight: 20,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5),
                      border: OutlineInputBorder(
                          gapPadding: 3,
                          borderSide: BorderSide(color: Colors.black)),
                    )),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              "DEAL NOW",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 23, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
