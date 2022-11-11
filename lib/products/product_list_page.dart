import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/helper/debouncer.dart';
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

  createDataTableRows(List<Product> products) {
    List<DataRow> rows = [];
    var i = 0;
    products.forEach((product) {
      var color = i % 2 == 0 ? Colors.grey[100] : Colors.grey[200];
      i++;
      rows.add(DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // All rows will have the same selected color.
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            }
            // Even rows will have a grey color.

            if (i % 2 == 0) {
              return Colors.grey.withOpacity(0.3);
            }
            return null; // Use default value for other states and odd rows.
          }),
          cells: [
            DataCell(
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            ),
            DataCell(
              Text(product.id.toString()),
            ),
            DataCell(Text(product.sku.toString())),
            DataCell(
              Text(product.name),
            ),
            DataCell(
              Text(product.price.toString()),
            ),
            DataCell(
              Text(product.ean.toString()),
            ),
            DataCell(
              Text(product.width.toString()),
            ),
            DataCell(
              Text(product.height.toString()),
            ),
            DataCell(
              Text(product.depth.toString()),
            ),
            DataCell(
              Text(product.weight.toString()),
            ),
            DataCell(
              Checkbox(value: product.active, onChanged: (value) {}),
            ),
          ]));
    });

    return rows;
  }

  getList() {
    return FutureBuilder<List<Product>>(
      future: getProduct,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(snapshot.data![index].id.toString()),
                title: Text(snapshot.data![index].name),
                subtitle: Row(
                  children: [
                    Text('Price: '),
                    Text(snapshot.data![index].price.toString()),
                    Text(' / Sku: '),
                    Text(snapshot.data![index].sku.toString()),
                    Text(' / Active: '),
                    Text(snapshot.data![index].active.toString())
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Fehler');
        } else {
          return loadingData;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getList()),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getList()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, ProductFormPage.url);
                }),
            body: Row(children: [
              getOpenShelvesDrawer(context),
              Expanded(
                child: ListView(children: [
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'At least 2 Characters'),
                    onChanged: (value) => {
                      if (value.length > 1)
                        {
                          setState(() {
                            getProduct = searchProducts(value);
                          }),
                        },
                      if (value.length == 0)
                        {
                          setState(() {
                            getProduct = getProducts();
                          })
                        },
                    },
                  ),
                  FutureBuilder<List<Product>>(
                    future: getProduct,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DataTable(columns: [
                          DataColumn(label: Expanded(child: Text('#'))),
                          DataColumn(label: Expanded(child: Text('ID'))),
                          DataColumn(label: Expanded(child: Text('SKU'))),
                          DataColumn(
                              label: Expanded(child: Text('Productname'))),
                          DataColumn(label: Expanded(child: Text('Price'))),
                          DataColumn(label: Expanded(child: Text('EAN'))),
                          DataColumn(label: Expanded(child: Text('Width'))),
                          DataColumn(label: Expanded(child: Text('Height'))),
                          DataColumn(label: Expanded(child: Text('Depth'))),
                          DataColumn(label: Expanded(child: Text('Weight'))),
                          DataColumn(label: Expanded(child: Text('Active'))),
                        ], rows: createDataTableRows(snapshot.data!));
                      } else if (snapshot.hasError) {
                        return Text('Fehler');
                      } else {
                        return loadingData;
                      }
                    },
                  ),
                ]),
              )
            ])));
  }
}
