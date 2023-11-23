import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/widgets/inventory_table.dart';
import 'package:openshelves/warehouseplace/widgets/invetory_list.dart';
import 'package:openshelves/warehouseplace/widgets/warehouseform.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class WarehousePlacePageArguments {
  final WarehousePlace warehousePlace;
  WarehousePlacePageArguments(this.warehousePlace);
}

class WarehousePlacePage extends StatefulWidget {
  static const String url = 'warehouseplace/form';
  final Store<AppState> store;
  const WarehousePlacePage({
    Key? key,
    required this.store,
  }) : super(key: key);
  @override
  _WarehousePlacePageState createState() => _WarehousePlacePageState();
}

class _WarehousePlacePageState extends State<WarehousePlacePage> {
  final futureWarehouses = getWarehouses();
  late Future<List<InventoryLevel>> futureInventoryLevel;

  bool editMode = false;

  late WarehousePlace wp;

  String name = '';
  int? id;
  Warehouse? w;
  TextEditingController idController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.store.state.selectedWarehousePlace != null) {
      wp = widget.store.state.selectedWarehousePlace!;
      // if (wp!.id != null) {
      //   futureInventoryLevel = getInventoryLevelsByInventoryId(wp!.id!);
      // } else {
      //   futureInventoryLevel = [] as Future<List<InventoryLevel>>;
      // }
    } else {
      Navigator.pushNamed(
        context,
        WarehousePlaceListPage.url,
      );
    }
  }
  //  futureInventoryLevel = getInventoryLevelsByInventoryId(wp!.id!);

  @override
  dispose() {
    super.dispose();
    widget.store.dispatch(SelectWarehousePlaceAction(null));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: ListView(children: [
              WarehouseForm(wp: wp),
              InventoryList(wp: wp, store: widget.store)
            ])),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: ListView(children: [
              WarehouseForm(wp: wp),
              InventoryList(wp: wp, store: widget.store)
            ])),
        desktopBody: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //     child: const Icon(Icons.add),
            //     onPressed: () async {
            //       await widget.store.dispatch(SelectIncomingStateModelAction(
            //           IncomingStateModel(warehousePlaceId: wp?.id ?? 0)));
            //     }),
            body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: ListView(children: [
            WarehouseForm(wp: wp),
            wp != null && wp!.id != null
                ? InventoryTable(widget: widget, wp: wp)
                : const Text('Noch Keine Daten')
          ]))
        ])));
  }
}
