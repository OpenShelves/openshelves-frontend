import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';

class WarehouseListPage extends StatefulWidget {
  const WarehouseListPage({Key? key}) : super(key: key);
  static const String url = 'warehouses';

  @override
  State<WarehouseListPage> createState() => _WarehouseListPageState();
}

getList() {}

class _WarehouseListPageState extends State<WarehouseListPage> {
  getList() {
    return Row(children: [
      getOpenShelvesDrawer(context),
      Expanded(
          child: FutureBuilder<List<Warehouse>>(
        future: getProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].address.name1 +
                        ' ' +
                        snapshot.data![index].address.city.toString()),
                    onTap: () {
                      print('go');
                      Navigator.pushNamed(context, WarhouseForm.url,
                          arguments:
                              WarehousePageArguments(snapshot.data![index]));
                    },
                  );
                });
            // print(snapshot.data);
            return Text("data");
          }
          return Center(child: CircularProgressIndicator());
        },
      ))
    ]);
  }

  Future<List<Warehouse>> getProducts = getWarehouses();

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
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, WarhouseForm.url,
                      arguments: WarehousePageArguments(
                          Warehouse(name: '', address: Address(name1: ''))));
                }),
            body: getList()));
  }
}
