import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/form/product_tech_data_form.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/form/product_main_data_form.dart';
import 'package:openshelves/products/product_warehouse_place_list.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/invetory_table.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:openshelves/widgets/label_detail.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InventoryTableSource extends DataTableSource {
  List<InventoryLevel> data;

  BuildContext context;
  ProductFormPage widget;
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
            getWarehousePlace(inventory.warehousePlacesId)
                .then((warehousePlace) {
              widget.store.dispatch(SelectWarehousePlaceAction(warehousePlace));
              Navigator.pushNamed(
                context,
                WarehousePlacePage.url,
              );
            });
          },
          icon: const Icon(Icons.arrow_right)))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

getRow(String label, String value) {
  return Row(
    children: [Text(label), Text(value)],
  );
}

class ProductFormPage extends StatefulWidget {
  final Store<AppState> store;
  const ProductFormPage({Key? key, required this.store}) : super(key: key);
  static const String url = 'product/form';
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  Future<List<InventoryLevel>>? futureInventoryLevel;
  int total = 0;
  bool editMode = false;
  late Product product;
  @override
  initState() {
    super.initState();
    if (widget.store.state.selectedProduct != null) {
      product = widget.store.state.selectedProduct!;
      futureInventoryLevel = getInventoryLevelsByProductId(product.id!);

      futureInventoryLevel?.then((levels) {
        levels.forEach((element) {
          total += int.parse(element.quantity);
        });
        setState(() {
          total = total;
        });
      }).onError((error, stackTrace) => null);
    } else {
      product = Product(name: '', asin: '', ean: '');
    }
  }

  @override
  dispose() {
    super.dispose();
    widget.store.dispatch(SelectProductAction(null));
  }

  getProductView(Product product, context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: 80,
                height: 80,
                child: Image(
                    image: NetworkImage('https://picsum.photos/id/1/200/300')),
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(
                    "EAN:" + product.ean.toString(),
                  ),
                  Text(
                    "Stock:" + total.toString(),
                  ),
                ],
              )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Scaffold(
          drawer: const OpenShelvesDrawer(),
          appBar: openShelvesAppBar,
          body: ListView(
            children: [
              Switch.adaptive(
                  value: editMode,
                  onChanged: (value) {
                    setState(() {
                      editMode = value;
                    });
                  }),
              editMode
                  ? Column(children: [
                      ProductMainDataForm(product: product),
                      ProductTechDataForm(product: product)
                    ])
                  : getProductView(product, context),
              product.id != null
                  ? FutureBuilder<List<InventoryLevel>>(
                      future: futureInventoryLevel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            total = snapshot.data!.length;
                            return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: WarehousePlaceList(
                                  inventoryLevels: snapshot.data!,
                                  store: widget.store,
                                ));
                          } else {
                            return Center(
                                child: Text(AppLocalizations.of(context)!
                                    .no_data_found));
                          }
                        } else {
                          return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .waiting_for_data));
                        }
                      })
                  : const Text('No data'),
            ],
          )),
      tabletBody: const Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            const OpenShelvesDrawer(),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(
                      children: [
                        Text(product.name,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: Theme.of(context).textTheme.headlineLarge),
                        const Divider(),
                        Wrap(
                          spacing: 50,
                          children: [
                            LabelDetail(
                                label: 'OSID',
                                value: product.id.toString().padLeft(6, '0')),
                            LabelDetail(
                                label: AppLocalizations.of(context)!.quantity,
                                value: product.quantity.toString()),
                            LabelDetail(
                                label: AppLocalizations.of(context)!.quantity,
                                value: product.updatedAt.toString()),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  LabelDetail(
                                      label: 'EAN',
                                      value: product.ean.toString()),
                                ],
                              ),
                              const SizedBox(
                                width: 600,
                                height: 400,
                                child: Image(
                                    image: NetworkImage(
                                        'https://picsum.photos/600/400')),
                              ),
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: ProductMainDataForm(product: product)),
                            Expanded(
                                flex: 1,
                                child: ProductTechDataForm(product: product)),
                          ],
                        ),
                        FutureBuilder<List<InventoryLevel>>(
                            future: futureInventoryLevel,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return InventoryTable(
                                      columns: const [
                                        DataColumn(label: Text('Quantity')),
                                        DataColumn(label: Text('Product')),
                                        DataColumn(
                                            label: Text('Warehouse Place')),
                                        DataColumn(label: Text('#')),
                                      ],
                                      source: InventoryTableSource(
                                          data: snapshot.data!,
                                          context: context,
                                          widget: widget));
                                } else {
                                  return Center(
                                      child: Text(AppLocalizations.of(context)!
                                          .no_data_found));
                                }
                              } else {
                                return Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .waiting_for_data));
                              }
                            })
                      ],
                    )))
          ])),
    );
  }
}
