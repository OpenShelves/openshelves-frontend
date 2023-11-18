import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

getToken() async {
  var test = await storage.read(key: 'token').then((value) => value);
  return test;
}

var openShelvesAppBar = AppBar(
  title: const Text('OpenShelves'),
  centerTitle: false,
);

var loadingData = const Center(
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
// var URL = 'http://192.168.2.154:4090/api';
var URL = 'http://localhost:4090/api';
// var URL = 'http://localhost:4090/api';
