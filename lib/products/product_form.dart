import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/prodform.dart';
import 'package:openshelves/products/product_list_page.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/products/product_warehouse_place_list.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouseplace/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:redux/redux.dart';

getProductTechDataForm(Product product) {
  return Container(
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(border: Border.all()),
    child: Column(
      children: [
        const Text('Product Tech Data'),
        TextField(
          decoration: const InputDecoration(label: Text('Width in CM')),
          controller: TextEditingController(text: product.width.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Height in CM')),
          controller: TextEditingController(text: product.height.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Depth in CM')),
          controller: TextEditingController(text: product.depth.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Weight in Gram')),
          controller: TextEditingController(text: product.weight.toString()),
        ),
      ],
    ),
  );
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
    } else {
      product = Product(name: '', asin: '', ean: '');
    }
  }

  getProductMainDataForm(Product product) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Form(
          child: Column(
        children: [
          const Text('Main Product Data'),
          TextField(
            decoration: const InputDecoration(label: Text('ID')),
            enabled: false,
            controller: TextEditingController(text: product.id.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Produktname')),
            controller: TextEditingController(text: product.name),
            onChanged: (value) => {product.name = value},
          ),
          TextField(
            decoration: const InputDecoration(label: Text('ASIN')),
            controller: TextEditingController(text: product.asin),
            onChanged: (value) => {product.asin = value},
          ),
          TextField(
            decoration: const InputDecoration(label: Text('EAN')),
            controller: TextEditingController(text: product.ean),
            onChanged: (value) => {product.ean = value},
          ),
          ElevatedButton(
            onPressed: () {
              storeProduct(product).then((productBackend) {
                setState(() {
                  product = productBackend;
                });
                print(product);
              });
            },
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: const Icon(Icons.save)),
          )
        ],
      )),
    );
  }

  getProductView(Product product, context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 80,
                height: 80,
                child: const Image(
                    image: NetworkImage('https://picsum.photos/id/1/200/300')),
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
    print("rebuild");

    return ResponsiveLayout(
      mobileBody: Scaffold(
          drawer: getOpenShelvesDrawer(context),
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
                      getProductTechDataForm(product)
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
                                    inventoryLevels: snapshot.data!));
                          } else {
                            return const Center(
                                child: Text('No Inventory found'));
                          }
                        } else {
                          return const Center(child: Text('Waiting for data1'));
                        }
                        // return Center(child: CircularProgressIndicator());
                      })
                  : Text('No data'),
            ],
          )),
      tabletBody: const Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Expanded(flex: 1, child: getProductMainDataForm(product)),
            Expanded(flex: 1, child: getProductTechDataForm(product))
          ])),
    );
  }
}
