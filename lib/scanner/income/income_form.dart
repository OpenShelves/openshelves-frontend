import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/scanner/income/income_popmenu.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_model.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    setState(() {});
    productController.clear();
    productFocus.requestFocus();
  }

  List<IncomingModel> incoming = [];

  @override
  void initState() {
    super.initState();
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
                      getWarehousePlace(int.parse(value)).then(
                          (warehousePlace) {
                        setState(() {
                          this.warehousePlace = warehousePlace;
                          warehousePlaceName = warehousePlace.name;
                        });
                        //     });
                      }, onError: (message) {
                        final snackBar = SnackBar(
                          content: Text(message.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                  )
                : Text(warehousePlaceName,
                    style: (Theme.of(context).textTheme.headlineMedium)),
            TextFormField(
              controller: productController,
              focusNode: productFocus,
              decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.scanBarcode)),
              onFieldSubmitted: (value) {
                if (value.length == 13) {
                  var localProd = checkEANLocal(value);
                  if (localProd is IncomingModel) {
                    addProduct(localProd.product);
                  } else {
                    getProductByCode(value).then((value) {
                      addProduct(value);
                    }, onError: (message) {
                      productFocus.requestFocus();
                      productController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: productController.text.length);
                      final snackBar = SnackBar(
                        content: Text(message.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                } else {
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
                    style: (Theme.of(context).textTheme.headlineMedium)),
                trailing: IncomePopmenu(product: incoming[index].product));
          },
        )
      ]),
    );
  }
}
