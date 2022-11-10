import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/product_list_page.dart';

final storage = const FlutterSecureStorage();

getToken() async {
  var test = await storage.read(key: 'token').then((value) => value);

  return test;
}

getOpenShelvesDrawer(context) {
  return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          Text(
            'OpenShelves',
            style: TextStyle(fontSize: 30),
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('L O G I N'),
            onTap: () {
              Navigator.pushNamed(context, LoginPage.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('D A S H B O A R D'),
            onTap: () {
              Navigator.pushNamed(context, HomePage.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.table_rows),
            title: Text('P R O D U C T S'),
            onTap: () {
              Navigator.pushNamed(context, ProductPage.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('O R D E R S'),
            // trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('S E T T I N G S'),
          )
        ],
      ));
}

var openShelvesAppBar = AppBar(
  title: Text('OpenShelves'),
  centerTitle: false,
);

var loadingData = Center(
    child: Column(children: [
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
