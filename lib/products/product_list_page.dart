import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class ProductPage extends StatefulWidget {
  final Store<AppState> store;
  const ProductPage({Key? key, required this.store}) : super(key: key);
  static const String url = 'product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class ProductTableSource extends DataTableSource {
  List<Product> data;
  BuildContext context;
  Store store;
  ProductTableSource(
      {required this.data, required this.context, required this.store});
  @override
  DataRow? getRow(int index) {
    final product = data[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          store.dispatch(
            SelectProductAction(product),
          );
          Navigator.pushNamed(
            context,
            ProductFormPage.url,
          );
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
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> getProduct = getProducts();
  final productTablekey = new GlobalKey<PaginatedDataTableState>();
  int total = 0;

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
                  widget.store
                      .dispatch(SelectProductAction(snapshot.data![index]));
                  Navigator.pushNamed(
                    context,
                    ProductFormPage.url,
                  );
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
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    getProduct = getProducts();
                  });
                }),
            prefixIcon: const Icon(Icons.search),
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
            drawer: const OpenShelvesDrawer(),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ProductFormPage.url,
                  );
                }),
            body: Column(
                children: [getSearchfield(), Expanded(child: getList())])),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: getList()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ProductFormPage.url,
                  );
                }),
            body: Row(children: [
              const OpenShelvesDrawer(),
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
                                data: snapshot.data!,
                                context: context,
                                store: widget.store));
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
