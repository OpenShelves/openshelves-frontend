import 'package:flutter/material.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/products/product_list_page.dart';

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
        LoginPage.url: (context) => const LoginPage(),
      },
      // home: ResponsiveLayout(
      //   desktopBody: DesktopScaffold(),
      //   mobileBody: MobileScaffold(),
      //   tabletBody: TabletScaffold(),
      // ),
    );
  }
}
