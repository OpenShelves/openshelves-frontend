import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/product_list_page.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';

const storage = FlutterSecureStorage();

getToken() async {
  var test = await storage.read(key: 'token').then((value) => value);

  return test;
}

getOpenShelvesDrawer(context) {
  return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          const Text(
            'OpenShelves',
            style: TextStyle(fontSize: 30),
          ),
          const Divider(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('L O G I N'),
            onTap: () {
              Navigator.pushNamed(context, LoginPage.url);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('D A S H B O A R D'),
            onTap: () {
              Navigator.pushNamed(context, HomePage.url);
            },
          ),
          ListTile(
            leading: const Icon(Icons.table_rows),
            title: const Text('P R O D U C T S'),
            onTap: () {
              Navigator.pushNamed(context, ProductPage.url);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.warehouse),
          //   title: const Text('W A R E H O U S E'),
          //   onTap: () {
          //     Navigator.pushNamed(context, WarhouseForm.url);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.warehouse),
            title: const Text('W A R E H O U S E S'),
            onTap: () {
              Navigator.pushNamed(context, WarehouseListPage.url);
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('W A R E H O U S E PLACE'),
            onTap: () {
              Navigator.pushNamed(context, WarehousePlaceListPage.url);
            },
          ),
          const ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('O R D E R S'),
            // trailing: Icon(Icons.add),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('S E T T I N G S'),
          )
        ],
      ));
}

var openShelvesAppBar = AppBar(
  title: const Text('OpenShelves'),
  centerTitle: false,
);

var loadingData = Center(
    child: Column(children: const [
  Padding(padding: EdgeInsets.only(top: 50)),
  SizedBox(
    width: 60,
    height: 60,
    child: CircularProgressIndicator(),
  ),
  Padding(
    padding: EdgeInsets.only(top: 20),
    child: Text('Awaiting result...'),
  )
]));
var URL = 'http://localhost:4090/api';
