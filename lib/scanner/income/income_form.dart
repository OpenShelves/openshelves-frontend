import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/warehouseplace/inventory_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class IncomePage extends StatefulWidget {
  final Store<AppState> store;
  const IncomePage({Key? key, required this.store}) : super(key: key);
  static const String url = 'income';
  @override
  State<IncomePage> createState() => _IncomePageState();
}

class IncomingModel {
  int quantity;
  Product product;
  IncomingModel({required this.product, required this.quantity});
}

class IncomingStateModel {
  int warehousePlaceId;
  IncomingStateModel({required this.warehousePlaceId});
}

class _IncomePageState extends State<IncomePage> {
  WarehousePlace? warehousePlace;
  String warehousePlaceName = '';
  TextEditingController productController = TextEditingController();
  FocusNode productFocus = FocusNode();
  checkEANLocal(String code) {
    return null;
    int index = incoming.indexWhere(
      (element) => code == element.product.ean,
    );
    print(index);
    if (index > -1) {
      var prod = incoming.firstWhere(
        (element) => code == element.product.ean,
      );
      print(prod);
      return prod;
    } else {
      return null;
    }
  }

  addProduct(Product product) {
    IncomingModel i = incoming.firstWhere(
      (element) => product.id == element.product.id,
      orElse: () {
        incoming.add(IncomingModel(product: product, quantity: 1));
        return IncomingModel(product: product, quantity: 1);
      },
    );
    i.quantity++;
    setState(() {
      print('setstaze');
    });
    productController.clear();
    productFocus.requestFocus();
    print('aftersetstaze');
  }

  List<IncomingModel> incoming = [];

  @override
  void initState() {
    super.initState();
    print('initState income');
    print(widget.store.state.incomingStateModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: openShelvesAppBar,
      drawer: const OpenShelvesDrawer(),
      body: Column(children: [
        Card(
            child: Form(
                child: Column(
          children: [
            warehousePlaceName.isEmpty
                ? TextFormField(
                    decoration:
                        const InputDecoration(label: Text('WarehousePlaceId')),
                    onChanged: (value) {
                      //   setState(() {
                      //     warehouse_id = int.parse(value);
                      getWarehousePlace(int.parse(value)).then(
                          (warehousePlace) {
                        print(warehousePlace);
                        setState(() {
                          this.warehousePlace = warehousePlace;
                          warehousePlaceName = warehousePlace.name;
                        });
                        //     });
                      }, onError: (message) {
                        print(message);
                        final snackBar = SnackBar(
                          content: Text(message.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                  )
                : Text(warehousePlaceName,
                    style: (Theme.of(context).textTheme.headline3)),
            TextFormField(
              controller: productController,
              focusNode: productFocus,
              decoration: const InputDecoration(label: Text('Product')),
              onFieldSubmitted: (value) {
                if (value.length == 13) {
                  var localProd = checkEANLocal(value);
                  if (localProd is IncomingModel) {
                    addProduct(localProd.product);
                  } else {
                    getProductByCode(value).then((value) {
                      addProduct(value);
                      // productFocus.requestFocus();
                    }, onError: (message) {
                      final snackBar = SnackBar(
                        content: Text(message.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                } else {
                  // productFocus.requestFocus();
                  productController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: productController.text.length);
                  productFocus.requestFocus();
                }
              },
            ),
            IconButton(
                onPressed: () {
                  incoming.forEach((item) {
                    print(item);
                    Inventory inventory = Inventory(
                        quantity: item.quantity,
                        warehousePlacesId: warehousePlace!.id!,
                        productsId: item.product.id!);
                    storeInventory(inventory);
                  });
                },
                icon: const Icon(Icons.save))
          ],
        ))),
        ListView.builder(
          shrinkWrap: true,
          itemCount: incoming.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(incoming[index].product.name),
                leading: Text(incoming[index].quantity.toString(),
                    style: (Theme.of(context).textTheme.headline5)),
                trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text('REMOVE'),
                          value: 'deleteItem',
                        ),
                        const PopupMenuItem(
                            child: Text('change Quantity'),
                            value: 'changeQuantity')
                      ];
                    },
                    onSelected: (String value) => {
                          print(value),
                          if (value == 'deleteItem')
                            {}
                          else if (value == 'changeQuantity')
                            {},
                        }));
          },
        )
      ]),
    );
  }
}
