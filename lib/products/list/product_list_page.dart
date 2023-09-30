import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/list/product_list.dart';
import 'package:openshelves/products/list/product_table.dart';
import 'package:openshelves/products/list/product_search_field.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class ProductPage extends StatefulWidget {
  final Store<AppState> store;
  const ProductPage({Key? key, required this.store}) : super(key: key);
  static const String url = 'product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> getProduct = getProducts();
  final productTablekey = GlobalKey<PaginatedDataTableState>();
  int total = 0;

  getList() {
    return FutureBuilder<List<Product>>(
      future: getProduct,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          total = snapshot.data!.length;
          return ProductList(products: snapshot.data!, store: widget.store);
        } else if (snapshot.hasError) {
          return const Text('Fehler');
        } else {
          return loadingData;
        }
      },
    );
  }

  void onSearch(result) {
    setState(() {
      getProduct = result;
    });
  }

  void onProductFound(Product product) {
    widget.store.dispatch(
      SelectProductAction(product),
    );
    Navigator.pushNamed(
      context,
      ProductFormPage.url,
    );
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
            body: Column(children: [
              ProductSearchFieled(
                  onSearch: onSearch, onProductFound: onProductFound),
              Expanded(child: getList())
            ])),
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
                  ProductSearchFieled(
                    onSearch: onSearch,
                    onProductFound: onProductFound,
                  ),
                  FutureBuilder<List<Product>>(
                    future: getProduct,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ProductTable(
                            data: snapshot.data!, store: widget.store);
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
