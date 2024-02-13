import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/drawer.dart';

class WarehousePlaceListPage extends StatefulWidget {
  const WarehousePlaceListPage({Key? key}) : super(key: key);
  static const String url = 'warehouseplaces';

  @override
  State<WarehousePlaceListPage> createState() => _WarehousePlaceListPageState();
}

class _WarehousePlaceListPageState extends State<WarehousePlaceListPage> {
  FloatingActionButton getfb(context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            WarehousePlacePage.url,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            floatingActionButton: getfb(context),
            drawer: const OpenShelvesDrawer(),
            body: FutureBuilder<List<WarehousePlace>>(
              future: getWarehousePlaces(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      WarehousePlace warehousePlace = snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              WarehousePlacePage.url +
                                  '/' +
                                  warehousePlace.id.toString());
                        },
                        title: Text(warehousePlace.name),
                        subtitle: Text(warehousePlace.warehouse!.name +
                            " / " +
                            warehousePlace.warehouse!.address.city.toString()),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )),
        tabletBody: Scaffold(
            floatingActionButton: getfb(context),
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: const Text("was2")),
        desktopBody: Scaffold(
            floatingActionButton: getfb(context),
            body: Row(children: [
              const OpenShelvesDrawer(),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder<List<WarehousePlace>>(
                        future: getWarehousePlaces(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                WarehousePlace warehousePlace =
                                    snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        WarehousePlacePage.url +
                                            '/' +
                                            warehousePlace.id.toString());
                                  },
                                  title: Text(warehousePlace.name),
                                  subtitle: Text(
                                      warehousePlace.warehouse!.name +
                                          " / " +
                                          warehousePlace.warehouse!.address.city
                                              .toString()),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      )))
            ])));
  }
}
