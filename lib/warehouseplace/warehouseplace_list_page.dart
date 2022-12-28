import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';

class WarehousePlaceListPage extends StatefulWidget {
  const WarehousePlaceListPage({Key? key}) : super(key: key);
  static const String url = 'warehouseplaces';

  @override
  State<WarehousePlaceListPage> createState() => _WarehousePlaceListPageState();
}

class _WarehousePlaceListPageState extends State<WarehousePlaceListPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: Text("")),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: Text("")),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  // Navigator.pushNamed(context, ProductFormPage.url,
                  //     arguments: ProductPageArguments(Product(name: '')));
                }),
            body: Row(children: [
              getOpenShelvesDrawer(context),
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
                                  title: Text(warehousePlace.name),
                                  subtitle: Text(warehousePlace.warehouse.name +
                                      " / " +
                                      warehousePlace.warehouse.address.city
                                          .toString()),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )))
            ])));
  }
}
