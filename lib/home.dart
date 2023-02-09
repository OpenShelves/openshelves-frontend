import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/products/products_total_model.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/widgets/statcard.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  const HomePage({Key? key, required this.store}) : super(key: key);
  static const String url = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final totalProductsFuture = getTotalProducts();
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
          appBar: openShelvesAppBar,
          drawer: getOpenShelvesDrawer(context),
          body: Column(children: [const Text('D A S H B O A R D ')]),
        ),
        tabletBody: const Text("TO BE DONE"),
        desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: totalProductsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final totalProducts =
                                  snapshot.data as ProductsTotal;
                              return StatCard(
                                  headline: 'Products',
                                  body: Column(children: [
                                    const Text('Different:'),
                                    Text(
                                      totalProducts.products.toString(),
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text('Quantity:'),
                                    Text(
                                      totalProducts.quantity.toString(),
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                  headlineColor: Colors.blue);
                            } else {
                              return const Center(child: Text('No data found'));
                            }
                          } else {
                            return Center(
                                child: StatCard(
                              headline: 'Products',
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                              headlineColor: Colors.blue,
                            ));
                          }
                          // return Center(child: CircularProgressIndicator());
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      StatCard(
                          headline: 'Orders',
                          body: Text(
                            '19',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          headlineColor: Colors.green),
                      SizedBox(
                        width: 10,
                      ),
                      StatCard(
                          headline: 'Earnings',
                          body: Text(
                            "2402\$",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          headlineColor: Colors.purple),
                      SizedBox(
                        width: 10,
                      ),
                      StatCard(
                          headline: 'Expenses',
                          body: Text(
                            "-1241\$",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          headlineColor: Colors.red),
                    ],
                  )
                ]))
          ]),
        ));
  }
}
