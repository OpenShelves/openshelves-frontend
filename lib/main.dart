import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_list_page.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:redux/redux.dart';

@immutable
class AppState {
  final String _animal;
  final String _loginToken;
  AppState(this._animal, this._loginToken);
  AppState.initialState()
      : _animal = "Koala",
        _loginToken = "";
  String get animal => _animal;
  String get loginToken => _loginToken;
}

class TestAction {
  final String _animal;

  TestAction(this._animal);
}

class LogInAction {
  final String _loginToken;

  LogInAction(this._loginToken);
}

AppState reducer(AppState prev, dynamic action) {
  print('reducer called with action: $action');
  if (action is LogInAction) {
    return loginReducer(prev, action);
  } else {
    return prev;
  }
}

AppState loginReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(prev.animal, action._loginToken);
}

void main() {
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
        ProductPage.url: (context) => const ProductPage(),
        ProductFormPage.url: (context) => const ProductFormPage(),
        LoginPage.url: (context) => LoginPage(
              store: store,
            ),
        WarhouseForm.url: (context) => const WarhouseForm(),
        WarehouseListPage.url: (context) => const WarehouseListPage(),
        WarehousePlaceListPage.url: (context) => const WarehousePlaceListPage(),
        WarehousePlacePage.url: (context) => const WarehousePlacePage(),
        IncomePage.url: (context) => const IncomePage(),
      },

      // home: ResponsiveLayout(
      //   desktopBody: DesktopScaffold(),
      //   mobileBody: MobileScaffold(),
      //   tabletBody: TabletScaffold(),
      // ),
    );
  }
}
