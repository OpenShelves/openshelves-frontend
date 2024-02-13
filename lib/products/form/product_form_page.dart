import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/form/product_tech_data_form.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/form/product_main_data_form.dart';
import 'package:openshelves/products/product_warehouse_place_list.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/products/widgets/product_inventory_table.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:openshelves/widgets/label_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getRow(String label, String value) {
  return Row(
    children: [Text(label), Text(value)],
  );
}

class ProductFormPage extends StatefulWidget {
  final int? id;
  const ProductFormPage({Key? key, this.id}) : super(key: key);
  static const String url = 'product-form';
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  Future<List<InventoryLevel>>? futureInventoryLevel;
  int total = 0;
  bool editMode = false;
  late Product product = Product(name: '', asin: '', ean: '');

  final mainFormStateKey = GlobalKey<FormState>();
  final techFormStateKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    if (widget.id != null) {
      getProductById(widget.id!).then((prod) {
        setState(() {
          product = prod;
        });

        // futureInventoryLevel = getInventoryLevelsByProductId(product.id!);
      });

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

  getProductView(Product product, context) {
    return Card(
        // margin: const EdgeInsets.all(8),
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
                      ProductMainDataForm(
                        product: product,
                        onSubmit: (Product product) {},
                        formKey: mainFormStateKey,
                      ),
                      ProductTechDataForm(
                          product: product, formKey: techFormStateKey)
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
                                // margin: const EdgeInsets.all(8.0),
                                child: WarehousePlaceList(
                              inventoryLevels: snapshot.data!,
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
                                value: total.toString()),
                            LabelDetail(
                                label: 'EAN', value: product.ean.toString()),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                children: [],
                              ),
                              SizedBox(
                                width: 600,
                                height: 400,
                                child: Image(
                                    image: product.image != null
                                        ? NetworkImage(product.image!)
                                        : const NetworkImage(
                                            'https://picsum.photos/id/1/200/300')),
                              ),
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: ProductMainDataForm(
                                    formKey: mainFormStateKey,
                                    product: product,
                                    onSubmit: (Product product) {})),
                            Expanded(
                                flex: 1,
                                child: ProductTechDataForm(
                                  product: product,
                                  formKey: techFormStateKey,
                                )),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              var valid =
                                  mainFormStateKey.currentState!.validate();
                              var valid2 =
                                  techFormStateKey.currentState!.validate();
                              if (valid && valid2) {
                                storeProduct(product).then((productBackend) {
                                  setState(() {
                                    product = productBackend;
                                  });
                                });
                              }
                            },
                            icon: const Icon(Icons.save)),
                        ProductInventoryTable(product: product, widget: widget)
                      ],
                    )))
          ])),
    );
  }
}
