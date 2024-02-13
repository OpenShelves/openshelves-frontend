import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/warehouseplace/widgets/inventory_changes_table.dart';
import 'package:openshelves/warehouseplace/widgets/inventory_table.dart';
import 'package:openshelves/warehouseplace/widgets/invetory_list.dart';
import 'package:openshelves/warehouseplace/widgets/warehouseform.dart';
import 'package:openshelves/widgets/drawer.dart';

class WarehousePlacePage extends StatefulWidget {
  static const String url = 'warehouseplace-form';
  final int? id;
  const WarehousePlacePage({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _WarehousePlacePageState createState() => _WarehousePlacePageState();
}

class _WarehousePlacePageState extends State<WarehousePlacePage> {
  final futureWarehouses = getWarehouses();
  late Future<List<InventoryLevel>> futureInventoryLevel;

  bool editMode = false;

  WarehousePlace wp = WarehousePlace(
    name: '',
    warehouse: Warehouse(
      name: '',
      address: Address(
        name1: '',
        name2: '',
        street: '',
        zip: '',
        city: '',
        country: '',
      ),
    ),
  );

  String name = '';
  int? id;
  Warehouse? w;
  TextEditingController idController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.id != null) {
      futureInventoryLevel = getInventoryLevelsByInventoryId(widget.id!);
      getWarehousePlace(widget.id!).then((value) {
        setState(() {
          wp = value;
        });
      });
    } else {
      Navigator.pushNamed(
        context,
        WarehousePlaceListPage.url,
      );
    }
  }
  //  futureInventoryLevel = getInventoryLevelsByInventoryId(wp!.id!);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: ListView(children: [
              wp.id != null
                  ? InventoryList(id: wp.id!)
                  : const Text('Noch Keine Daten'),
              WarehouseForm(wp: wp),
            ])),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: ListView(children: const [
              // WarehouseForm(wp: wp),
              // InventoryList(wp: wp, store: widget.store)
            ])),
        desktopBody: Scaffold(
            body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: ListView(children: [
            WarehouseForm(wp: wp),
            wp.id != null
                ? InventoryTable(widget: widget, wp: wp)
                : const Text('Noch Keine Daten'),
            wp.id != null
                ? InventoryChangesTable(warehousePlaceId: wp.id!)
                : const Text('Noch Keine Daten'),
          ]))
        ])));
  }
}
