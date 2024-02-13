import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:openshelves/camera/camera_page.dart';
import 'package:openshelves/helpers/debouncer.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/scanner/income/income_popmenu.dart';
import 'package:openshelves/scanner/income/models/income_model.dart';
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

class IncomingStateModel {
  int warehousePlaceId;
  IncomingStateModel({required this.warehousePlaceId});
}

class _IncomePageState extends State<IncomePage> {
  final _debouncer = Debouncer(milliseconds: 100);
  WarehousePlace? warehousePlace;
  String warehousePlaceName = '';
  TextEditingController productController = TextEditingController();
  FocusNode productFocus = FocusNode();
  FocusNode warehousePlaceFocus = FocusNode();

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
    setState(() {
      incoming = incoming;
    });
    productController.clear();
    productFocus.requestFocus();
  }

  saveProducts() {
    incoming.forEach((item) {
      Inventory inventory = Inventory(
          quantity: item.quantity,
          warehousePlacesId: warehousePlace!.id!,
          productsId: item.product.id!);
      storeInventory(inventory);
    });
  }

  List<IncomingModel> incoming = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (warehousePlace == null) {
      warehousePlaceFocus.requestFocus();
    }
    return Scaffold(
      appBar: AppBar(
          title: warehousePlace != null
              ? Text('${warehousePlace?.barcode} / ${warehousePlace?.name}')
              : const Text('Scan WarehousePlace')),
      drawer: const OpenShelvesDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) async {
            switch (value) {
              case 0:
                saveProducts();
                break;
              case 1:
                WidgetsFlutterBinding.ensureInitialized();
                final cameras = await availableCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text('Take a picture'),
                      ),
                      body: CameraPage(cameras: cameras),
                    ),
                  ),
                );
                break;
              case 2:
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera), label: 'Take Picture'),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code), label: 'Scan Camera')
          ]),
      body: Column(children: [
        Card(
            child: Form(
                child: Column(
          children: [
            warehousePlaceName.isEmpty
                ? TextFormField(
                    focusNode: warehousePlaceFocus,
                    decoration:
                        const InputDecoration(label: Text('WarehousePlaceId')),
                    onChanged: (value) {
                      _debouncer.run(() {
                        getWarehousePlaceByBarcode(value).then(
                            (warehousePlace) {
                          setState(() {
                            this.warehousePlace = warehousePlace;
                            warehousePlaceName = warehousePlace.name;
                          });
                          productFocus.requestFocus();
                        }, onError: (message) {
                          // final snackBar = SnackBar(
                          // content: Text(message.toString()),
                          // );
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
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
          ],
        ))),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: incoming.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(incoming[index].product.name),
                leading: Text(incoming[index].quantity.toString(),
                    style: (Theme.of(context).textTheme.headlineMedium)),
                trailing: IncomePopMenu(
                    incomingModel: incoming[index],
                    onQuantityChanged: (IncomingModel incomingModel) {
                      setState(() {
                        incoming[index].quantity = incomingModel.quantity;
                        incoming = incoming;
                      });
                    },
                    onDeleteItem: (IncomingModel incomingModel) {
                      setState(() {
                        incoming.remove(incomingModel);
                      });
                    }));
          },
        ))
      ]),
    );
  }
}
