import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/change_inventory.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/only_form.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';

class WarehousePlacePageArguments {
  final WarehousePlace warehousePlace;
  WarehousePlacePageArguments(this.warehousePlace);
}

class WarehousePlacePage extends StatefulWidget {
  const WarehousePlacePage({Key? key}) : super(key: key);
  @override
  _WarehousePlacePageState createState() => _WarehousePlacePageState();
  static const String url = 'warehouseplace/form';
}

class _WarehousePlacePageState extends State<WarehousePlacePage> {
  final futureWarehouses = getWarehouses();
  final _formKey = GlobalKey<FormState>();
  WarehousePlace? wp;

  List<Warehouse> _warehouses = [];
  String name = '';
  int? id;
  Warehouse? w;
  TextEditingController idController = TextEditingController();

  getExpanded() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Warehouse>>(
            future: futureWarehouses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Store the retrieved warehouse places in the _warehousePlaces field
                if (snapshot.hasData) {
                  _warehouses = snapshot.data!;
                }
                return Card(
                    margin: EdgeInsets.all(8),
                    child: WarehousePlaceFormOnly(
                      warehousePlace: wp!,
                      warehouses: _warehouses,
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      Navigator.pushNamed(context, WarehousePlaceListPage.url);
    }
    final wpa = args as WarehousePlacePageArguments;

    wp = args.warehousePlace;

    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getExpanded()),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getExpanded()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, WarehousePlacePage.url);
                }),
            body: Row(children: [
              getOpenShelvesDrawer(context),
              Expanded(
                  child: Column(children: [
                getExpanded(),
                ChangeInventoryForm(),
                FutureBuilder(
                  builder: (context, snapshot) {
                    return Text('asd');
                  },
                )
              ]))
            ])));
  }
}
