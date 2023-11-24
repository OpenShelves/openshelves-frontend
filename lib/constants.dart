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

final docStatus = <int, String>{
  1: 'Draft',
  2: 'Posted',
  3: 'Cancelled',
  4: 'Closed',
  5: 'Voided',
  6: 'Pending',
  7: 'Approved',
  8: 'Rejected',
  9: 'In Progress',
  10: 'Completed',
  11: 'Invoiced',
  12: 'Paid',
  13: 'Unpaid',
  14: 'Partially Paid',
  15: 'Partially Invoiced',
  16: 'Partially Received',
  17: 'Partially Shipped',
  18: 'Received',
  19: 'Shipped',
  20: 'Delivered',
  21: 'Partially Delivered',
  22: 'Partially Returned',
  23: 'Returned',
  24: 'Partially Fulfilled',
  25: 'Fulfilled',
  26: 'Partially Assembled',
  27: 'Assembled',
  28: 'Partially Picked',
  29: 'Picked',
  30: 'Partially Packed',
  31: 'Packed',
  32: 'Partially Shipped',
  33: 'Shipped',
  34: 'Partially Received',
  35: 'Received',
  36: 'Partially Invoiced',
  37: 'Invoiced',
  38: 'Partially Paid',
  39: 'Paid',
  40: 'Partially Billed',
  41: 'Billed',
  42: 'Partially Confirmed',
  43: 'Confirmed',
  44: 'Partially Approved',
  45: 'Approved',
  46: 'Partially Rejected',
  47: 'Rejected',
  48: 'Partially Completed',
  49: 'Completed',
  50: 'Partially Voided',
  51: 'Voided',
  52: 'Partially Cancelled',
  53: 'Cancelled',
  54: 'Partially Closed',
  55: 'Closed',
  56: 'Partially Voided',
  57: 'Voided',
  58: 'Partially Cancelled',
  59: 'Cancelled'
};

var buttons = docStatus.entries.map((e) {
  return ElevatedButton(
      onPressed: () {
        print(e.key);
      },
      child: Text(e.value));
});
