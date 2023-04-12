import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/only_form.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class WarehousePlacePageArguments {
  final WarehousePlace warehousePlace;
  WarehousePlacePageArguments(this.warehousePlace);
}

class WarehousePlacePage extends StatefulWidget {
  final Store<AppState> store;
  const WarehousePlacePage({Key? key, required this.store}) : super(key: key);
  @override
  _WarehousePlacePageState createState() => _WarehousePlacePageState();
  static const String url = 'warehouseplace/form';
}

class InventoryTableSource extends DataTableSource {
  List<InventoryLevel> data;

  BuildContext context;
  WarehousePlacePage widget;
  InventoryTableSource(
      {required this.data, required this.context, required this.widget});
  @override
  DataRow? getRow(int index) {
    final inventory = data[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(inventory.quantity)),
      DataCell(Text(inventory.productsName)),
      DataCell(Text(inventory.warehousePlacesName)),
      DataCell(IconButton(
          onPressed: () {
            getProductById(inventory.productsId).then((product) {
              widget.store.dispatch(SelectProductAction(product));
              Navigator.pushNamed(
                context,
                ProductFormPage.url,
              );
            });
          },
          icon: Icon(Icons.arrow_right)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
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

  getExpanded() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Warehouse>>(
            future: futureWarehouses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Store the retrieved warehouse places in the _warehousePlaces field
                if (snapshot.hasData) {
                  _warehouses = snapshot.data!;
                }
                return editMode
                    ? Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(children: [
                          Row(children: [
                            const Text('W A R E H O U S E P L A C E'),
                            Switch(
                              value: editMode,
                              onChanged: (val) {
                                setState(() {
                                  editMode = val;
                                });
                              },
                            )
                          ]),
                          WarehousePlaceFormOnly(
                            warehousePlace: wp!,
                            warehouses: _warehouses,
                          )
                        ]))
                    : ListTile(
                        title: Text(wp!.name),
                        subtitle: Text(wp!.warehouse.name +
                            ' / ' +
                            wp!.warehouse.address.city.toString()),
                        trailing: Switch(
                          value: editMode,
                          onChanged: (val) {
                            setState(() {
                              editMode = val;
                            });
                          },
                        ),
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
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
    futureInventoryLevel = getInventoryLevelsByInventoryId(wp!.id!);

    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: const OpenShelvesDrawer(),
            body: ListView(children: [
              getExpanded(),
              FutureBuilder<List<InventoryLevel>>(
                  future: futureInventoryLevel,
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
                                                  .headline5)),
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
            body: getExpanded()),
        desktopBody: Scaffold(
            body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: ListView(children: [
            getExpanded(),
            FutureBuilder<List<InventoryLevel>>(
              future: futureInventoryLevel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return PaginatedDataTable(
                        rowsPerPage: snapshot.data!.length,
                        columns: const [
                          DataColumn(label: Text('Quantity')),
                          DataColumn(label: Text('Product')),
                          DataColumn(label: Text('Warehouse Place')),
                          DataColumn(label: Text('#')),
                        ],
                        source: InventoryTableSource(
                            data: snapshot.data!,
                            context: context,
                            widget: widget));
                  } else {
                    return const Center(child: Text('No Products found'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ]))
        ])));
  }
}
