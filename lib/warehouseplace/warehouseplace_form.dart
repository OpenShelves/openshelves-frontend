import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/widgets/inventory_table.dart';
import 'package:openshelves/warehouseplace/widgets/warehouseform.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class WarehousePlacePageArguments {
  final WarehousePlace warehousePlace;
  WarehousePlacePageArguments(this.warehousePlace);
}

class WarehousePlacePage extends StatefulWidget {
  final Store<AppState> store;
  var createNewWP = false;
  WarehousePlacePage({Key? key, required this.store, this.createNewWP = false})
      : super(key: key);
  @override
  _WarehousePlacePageState createState() => _WarehousePlacePageState();
  static const String url = 'warehouseplace/form';
}

class _WarehousePlacePageState extends State<WarehousePlacePage> {
  final futureWarehouses = getWarehouses();
  late Future<List<InventoryLevel>> futureInventoryLevel;

  bool editMode = false;

  WarehousePlace? wp;

  List<Warehouse> _warehouses = [];
  String name = '';
  int? id;
  Warehouse? w;
  TextEditingController idController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.store.state.selectedWarehousePlace != null) {
      wp = widget.store.state.selectedWarehousePlace;
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
              FutureBuilder<List<InventoryLevel>>(
                  future: wp!.id != null
                      ? getInventoryLevelsByInventoryId(wp!.id!)
                      : [] as Future<List<InventoryLevel>>,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12))),
                                        child: ListTile(
                                          onTap: () {
                                            getProductById(snapshot
                                                    .data![index].productsId)
                                                .then((product) {
                                              widget.store.dispatch(
                                                  SelectProductAction(product));
                                              Navigator.pushNamed(
                                                context,
                                                ProductFormPage.url,
                                              );
                                            });
                                          },
                                          title: Text(snapshot
                                              .data![index].productsName),
                                          leading: Text(
                                              snapshot.data![index].quantity,
                                              style: (Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium)),
                                          trailing:
                                              const Icon(Icons.arrow_right),
                                        ),
                                      );
                                    })));
                      } else {
                        return const Center(child: Text('nodata'));
                      }
                    } else {
                      return const Center(child: Text('connectionsstate'));
                    }
                  })
            ])),
        tabletBody: Scaffold(
          appBar: openShelvesAppBar,
          drawer: const OpenShelvesDrawer(),
          body: WarehouseForm(wp: wp),
        ),
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
            InventoryTable(widget: widget, wp: wp)
          ]))
        ])));
  }
}
