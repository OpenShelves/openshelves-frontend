import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:openshelves/document/document_list_page.dart';
import 'package:openshelves/document/document_page.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/list/product_list_page.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/settings/settings_list_page.dart';
import 'package:openshelves/settings/tax/tax_list_page.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_form.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/state/appstate.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
        Locale('de'), // German
      ],
      title: 'OpenShelves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        print(settings);
        var uri = Uri.parse(settings.name!);
        var id = uri.pathSegments[1];
        if (uri.pathSegments.length == 2) {
          switch (uri.pathSegments.first) {
            case 'documents':
              if (id == 'new') {
                return MaterialPageRoute(
                    builder: (context) => DocumentPage(id: null));
              }
              return MaterialPageRoute(
                  builder: (context) => DocumentPage(id: int.parse(id)));
            case WarehousePlacePage.url:
              if (id == 'new') {
                return MaterialPageRoute(
                    builder: (context) => WarehousePlacePage(id: null));
              }
              return MaterialPageRoute(
                  builder: (context) => WarehousePlacePage(id: int.parse(id)));
            // if (id == 'new') {
            //   return MaterialPageRoute(
            //       builder: (context) => ProductFormPage(id: null));
            // }
            // return MaterialPageRoute(
            //     builder: (context) => ProductFormPage(id: int.parse(id)));
          }
        }
      },
      routes: {
        LoginPage.url: (context) => LoginPage(
              store: store,
            ),
        HomePage.url: (context) => HomePage(
              store: store,
            ),
        ProductPage.url: (context) => ProductPage(
              store: store,
            ),
        ProductFormPage.url: (context) => ProductFormPage(
              store: store,
            ),
        WarhouseForm.url: (context) => WarhouseForm(
              store: store,
            ),
        WarehouseListPage.url: (context) => WarehouseListPage(store: store),
        WarehousePlaceListPage.url: (context) => WarehousePlaceListPage(),
        IncomePage.url: (context) => IncomePage(
              store: store,
            ),
        // DocumentPage.url: (context) => DocumentPage(),

        DocumentListPage.url: (context) => DocumentListPage(
              store: store,
            ),
        SettingsListPage.url: (context) => const SettingsListPage(
            // store: store,
            ),
        TaxListPage.url: (context) => const TaxListPage(
            // store: store,
            ),
      },
    );
  }
}
