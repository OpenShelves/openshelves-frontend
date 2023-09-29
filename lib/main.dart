import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  WarehousePlace? _selectedWarehousePlace;

  IncomingStateModel? _incomingStateModel;
  AppState(this._loginToken, this._selectedProduct, this._selectedWarehouse,
      this._selectedWarehousePlace);

  AppState.initialState() : _loginToken = "";
  String get loginToken => _loginToken;
  Product? get selectedProduct => _selectedProduct;
  Warehouse? get selectedWarehouse => _selectedWarehouse;
  WarehousePlace? get selectedWarehousePlace => _selectedWarehousePlace;
  List<IncomingModel> get incoming => _incoming;
  IncomingStateModel? get incomingStateModel => _incomingStateModel;
}

class LogInAction {
  final String _loginToken;

  LogInAction(this._loginToken);
}

class SelectProductAction {
  final Product? _product;

  SelectProductAction(this._product);
}

class SelectWarehouseAction {
  final Warehouse _warehouse;

  SelectWarehouseAction(this._warehouse);
}

class SelectWarehousePlaceAction {
  final WarehousePlace _warehousePlace;

  SelectWarehousePlaceAction(this._warehousePlace);
}

class SelectIncomingStateModelAction {
  final IncomingStateModel _incomingStateModel;

  SelectIncomingStateModelAction(this._incomingStateModel);
}

AppState reducer(AppState prev, dynamic action) {
  print('reducer called with action: $action');
  if (action is LogInAction) {
    return loginReducer(prev, action);
  } else if (action is SelectProductAction) {
    return selectProductReducer(prev, action);
  } else if (action is SelectWarehouseAction) {
    return selectWarehouseReducer(prev, action);
  } else if (action is SelectIncomingStateModelAction) {
    return selectIncomingStateModelReducer(prev, action);
  } else if (action is SelectWarehousePlaceAction) {
    return selectWarehousePlaceReducer(prev, action);
  } else {
    return prev;
  }
}

AppState selectIncomingStateModelReducer(AppState prev, dynamic action) {
  print('selectIncomingStateModelReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, prev._selectedWarehousePlace);
}

AppState selectWarehousePlaceReducer(AppState prev, dynamic action) {
  print('selectWarehousePlaceReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, action._warehousePlace);
}

AppState selectWarehouseReducer(AppState prev, dynamic action) {
  print('selectWarehouseReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct, action._warehouse,
      prev._selectedWarehousePlace);
}

AppState loginReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(action._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, prev._selectedWarehousePlace);
}

AppState selectProductReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(prev.loginToken, action._product, prev._selectedWarehouse,
      prev._selectedWarehousePlace);
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  final store = Store(reducer, initialState: AppState.initialState());
  runApp(StoreProvider(store: store, child: MyApp(store: store)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('de'), // Spanish
      ],
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
        WarehousePlaceListPage.url: (context) =>
            WarehousePlaceListPage(store: store),
        WarehousePlacePage.url: (context) => WarehousePlacePage(store: store),
        IncomePage.url: (context) => IncomePage(
              store: store,
            ),
      },
    );
  }
}
