import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const String url = 'product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> getProduct = getProducts();

  createTableRows(List<Product> products) {
    List<TableRow> rows = [];
    var i = 0;
    products.forEach((product) {
      var color = i % 2 == 0 ? Colors.grey[100] : Colors.grey[200];
      i++;
      rows.add(TableRow(children: [
        ElevatedButton(onPressed: () {}, child: Icon(Icons.edit)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.id.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.sku.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.name),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.weight.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.width.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.height.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(product.depth.toString()),
        ),
      ], decoration: BoxDecoration(color: color)));
    });

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Text("TO BE DONE"),
        tabletBody: Text("TO BE DONE"),
        desktopBody: Scaffold(
            // appBar: openShelvesAppBar,
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, ProductFormPage.url);
                }),
            body: Row(children: [
              getOpenShelvesDrawer(context),
              Expanded(
                  child: ListView(children: [
                FutureBuilder<List<Product>>(
                  future: getProduct,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Table(
                        // border: TableBorder.all(color: Colors.grey),
                        children: createTableRows(snapshot.data!),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Fehler');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ])),
            ])));
  }
}
