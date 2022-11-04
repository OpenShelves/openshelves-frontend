import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_list_page.dart';
import 'package:openshelves/responsive/desktop.dart';
import 'package:openshelves/responsive/mobile.dart';
import 'package:openshelves/responsive/tablet.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenShelves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.url: (context) => const HomePage(),
        ProductPage.url: (context) => const ProductPage(),
        ProductFormPage.url: (context) => const ProductFormPage(),
      },
      // home: ResponsiveLayout(
      //   desktopBody: DesktopScaffold(),
      //   mobileBody: MobileScaffold(),
      //   tabletBody: TabletScaffold(),
      // ),
    );
  }
}
