import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/models/products_total_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/widgets/desktop_card.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:openshelves/widgets/statcard.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final Store<AppState> store;
  const HomePage({Key? key, required this.store}) : super(key: key);
  static const String url = '/dashboard';
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
          drawer: const OpenShelvesDrawer(),
          body: const Column(children: [Text('D A S H B O A R D ')]),
        ),
        tabletBody: const Text("TO BE DONE"),
        desktopBody: Scaffold(
          body: Row(children: [
            const OpenShelvesDrawer(),
            DesktopCard(
                title: 'D A S H B O A R D',
                primaryActions: [
                  ElevatedButton(
                      onPressed: () {
                        print('Hello');
                      },
                      child: const Text('Hello')),
                  ElevatedButton(
                      onPressed: () {
                        print('Hello2');
                      },
                      child: const Text('Hello2'))
                ],
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                          headline:
                                              AppLocalizations.of(context)!
                                                  .products,
                                          body: Column(children: [
                                            Text(AppLocalizations.of(context)!
                                                .differentItems),
                                            Text(
                                              totalProducts.products.toString(),
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(AppLocalizations.of(context)!
                                                .inStock),
                                            Text(
                                              totalProducts.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          headlineColor: Colors.blue);
                                    } else {
                                      return const Center(
                                          child: Text('No data found'));
                                    }
                                  } else {
                                    return const Center(
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
                              const SizedBox(
                                width: 10,
                              ),
                              StatCard(
                                  headline:
                                      AppLocalizations.of(context)!.orders,
                                  body: const Text(
                                    '19',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  headlineColor: Colors.green),
                              const SizedBox(
                                width: 10,
                              ),
                              StatCard(
                                  headline:
                                      AppLocalizations.of(context)!.earnings,
                                  body: const Text(
                                    "2402\$",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  headlineColor: Colors.purple),
                              const SizedBox(
                                width: 10,
                              ),
                              StatCard(
                                  headline:
                                      AppLocalizations.of(context)!.expenses,
                                  body: const Text(
                                    "-1241\$",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  headlineColor: Colors.red),
                            ],
                          ),
                          Card(
                              child: Text('Hello There !',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge))
                        ])))
          ]),
        ));
  }
}
