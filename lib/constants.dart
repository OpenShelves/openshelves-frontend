import 'package:flutter/material.dart';

var openShelvesDrawer = Drawer(
    child: Column(
  children: [
    ListTile(
      leading: Icon(Icons.article),
      title: Text('Products'),
    ),
    ListTile(
      leading: Icon(Icons.settings),
      title: Text('Settings'),
    )
  ],
));

var openShelvesAppBar = AppBar(
  title: Text(' '),
  centerTitle: false,
);

var URL = 'http://localhost:4090/api/';
