import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_list_page.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_list_page.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:redux/redux.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@immutable
class AppState {
  final String _loginToken;
  final List<IncomingModel> _incoming = [];
  Product? _selectedProduct;
  Warehouse? _selectedWarehouse;
  AppState(this._loginToken, this._selectedProduct, this._selectedWarehouse);
  AppState.initialState() : _loginToken = "";
  String get loginToken => _loginToken;
  Product? get selectedProduct => _selectedProduct;
  Warehouse? get selectedWarehouse => _selectedWarehouse;
  List<IncomingModel> get incoming => _incoming;
}

class LogInAction {
  final String _loginToken;

  LogInAction(this._loginToken);
}

class SelectProductAction {
  final Product _product;

  SelectProductAction(this._product);
}

class SelectWarehouseAction {
  final Warehouse _warehouse;

  SelectWarehouseAction(this._warehouse);
}

AppState reducer(AppState prev, dynamic action) {
  print('reducer called with action: $action');
  if (action is LogInAction) {
    return loginReducer(prev, action);
  } else if (action is SelectProductAction) {
    return selectProductReducer(prev, action);
  } else if (action is SelectWarehouseAction) {
    return selectWarehouseReducer(prev, action);
  } else {
    return prev;
  }
}

AppState selectWarehouseReducer(AppState prev, dynamic action) {
  print('selectWarehouseReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct, action._warehouse);
}

AppState loginReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(
      action._loginToken, prev.selectedProduct, prev._selectedWarehouse);
}

AppState selectProductReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(prev.loginToken, action._product, prev._selectedWarehouse);
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  final store = Store(reducer, initialState: AppState.initialState());
  runApp(StoreProvider(store: store, child: MyApp(store: store)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenShelves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.url: (context) => HomePage(
              store: store,
            ),
        ProductPage.url: (context) => ProductPage(
              store: store,
            ),
        ProductFormPage.url: (context) => ProductFormPage(
              store: store,
            ),
        LoginPage.url: (context) => LoginPage(
              store: store,
            ),
        WarhouseForm.url: (context) => WarhouseForm(
              store: store,
            ),
        WarehouseListPage.url: (context) => WarehouseListPage(store: store),
        WarehousePlaceListPage.url: (context) => const WarehousePlaceListPage(),
        WarehousePlacePage.url: (context) => WarehousePlacePage(store: store),
        IncomePage.url: (context) => IncomePage(
              store: store,
            ),
      },
    );
  }
}
