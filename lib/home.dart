import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String url = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Text("TO BE DONE"),
      tabletBody: Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton:
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Text('D A S H B O A R D ')
          ])),
    );
  }
}
