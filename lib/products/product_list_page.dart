import 'dart:async';

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

class ProductTableSource extends DataTableSource {
  List<Product> data;
  BuildContext context;
  ProductTableSource({required this.data, required this.context});
  @override
  DataRow? getRow(int index) {
    final product = data[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, ProductFormPage.url,
              arguments: ProductPageArguments(product));
        },
      )),
      DataCell(Text('${product.id}')),
      DataCell(Text('${product.sku}')),
      DataCell(Text('${product.name}')),
      DataCell(Text('${product.price}')),
      DataCell(Text('${product.ean}')),
      DataCell(Text('${product.width}')),
      DataCell(Text('${product.height}')),
      DataCell(Text('${product.depth}')),
      DataCell(Text('${product.weight}')),
      DataCell(Text('${product.active}')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> getProduct = getProducts();
  final productTablekey = new GlobalKey<PaginatedDataTableState>();
  int total = 0;

  createDataTableRows(List<Product> products, context) {
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
              return color;
            }
          }),
          cells: [
            DataCell(
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, ProductFormPage.url,
                        arguments: ProductPageArguments(product));
                  }),
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

  TextEditingController searchController = TextEditingController();
  getList() {
    return FutureBuilder<List<Product>>(
      future: getProduct,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          total = snapshot.data!.length;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(snapshot.data![index].id.toString()),
                title: Text(snapshot.data![index].name),
                onTap: () {
                  Navigator.pushNamed(context, ProductFormPage.url,
                      arguments: ProductPageArguments(snapshot.data![index]));
                },
                subtitle: Row(
                  children: [
                    const Text('Price: '),
                    Text(snapshot.data![index].price.toString()),
                    // const Text(' / Sku: '),
                    // Text(snapshot.data![index].sku.toString()),
                    // const Text(' / Active: '),
                    // Text(snapshot.data![index].active.toString())
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Fehler');
        } else {
          return loadingData;
        }
      },
    );
  }

  getSearchfield() {
    return Column(children: [
      TextField(
        controller: searchController,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    getProduct = getProducts();
                  });
                }),
            prefixIcon: Icon(Icons.search),
            hintText: 'At least 3 Characters'),
        onChanged: (value) => {
          if (value.length == 13)
            {
              setState(() {
                getProductByCode(value).then((value) => print);
                // productTablekey.currentState!.pageTo(0);
              }),
            }
          else if (value.length > 2)
            {
              setState(() {
                getProduct = searchProducts(value);
                // productTablekey.currentState!.pageTo(0);
              }),
            },
          if (value.isEmpty)
            {
              setState(() {
                getProduct = getProducts();
              })
            },
        },
      ),
      Text("Results: " + total.toString())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    getProduct.then((value) => total);
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, ProductFormPage.url,
                      arguments: ProductPageArguments(Product(name: '')));
                }),
            body: Column(
                children: [getSearchfield(), Expanded(child: getList())])),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getList()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, ProductFormPage.url,
                      arguments: ProductPageArguments(Product(name: '')));
                }),
            body: Row(children: [
              getOpenShelvesDrawer(context),
              Expanded(
                child: ListView(children: [
                  getSearchfield(),
                  FutureBuilder<List<Product>>(
                    future: getProduct,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return PaginatedDataTable(
                            key: productTablekey,
                            rowsPerPage: snapshot.data!.length < 20
                                ? snapshot.data!.length
                                : 20,
                            showFirstLastButtons: true,
                            availableRowsPerPage: [10, 20, 50],
                            columns: const [
                              DataColumn(label: Text('#')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('SKU')),
                              DataColumn(label: Text('Productname')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('EAN')),
                              DataColumn(label: Text('Width')),
                              DataColumn(label: Text('Height')),
                              DataColumn(label: Text('Depth')),
                              DataColumn(label: Text('Weight')),
                              DataColumn(label: Text('Active')),
                            ],
                            source: ProductTableSource(
                                data: snapshot.data!, context: context));
                        // return DataTable(columns: const [
                        //   DataColumn(label: Expanded(child: Text('#'))),
                        //   DataColumn(label: Expanded(child: Text('ID'))),
                        //   DataColumn(label: Expanded(child: Text('SKU'))),
                        //   DataColumn(
                        //       label: Expanded(child: Text('Productname'))),
                        //   DataColumn(label: Expanded(child: Text('Price'))),
                        //   DataColumn(label: Expanded(child: Text('EAN'))),
                        //   DataColumn(label: Expanded(child: Text('Width'))),
                        //   DataColumn(label: Expanded(child: Text('Height'))),
                        //   DataColumn(label: Expanded(child: Text('Depth'))),
                        //   DataColumn(label: Expanded(child: Text('Weight'))),
                        //   DataColumn(label: Expanded(child: Text('Active'))),
                        // ], rows: createDataTableRows(snapshot.data!, context));
                      } else if (snapshot.hasError) {
                        return const Text('No Products found');
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
