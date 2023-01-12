import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';

Future<Warehouse> storeWarehouse(Warehouse warehouse) async {
  var token = await getToken();
  final response = await http.post(Uri.parse(URL + '/warehouse'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(warehouse));

  if (response.statusCode == 200) {
    return Warehouse.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store product');
  }
}

Future<List<Warehouse>> getWarehouses() async {
  var token = await getToken();
  final response = await http.get(Uri.parse(URL + '/warehouses'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<Warehouse>.from(l.map((model) => Warehouse.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load warehouses');
  }
}

Future<Warehouse> getWarehouse(int id) async {
  var token = await getToken();
  final response = await http.get(
      Uri.parse(URL + '/warehouse/' + id.toString()),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    return Warehouse.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}

Future deleteWarehouse(int id) async {
  var token = await getToken();
  final response = await http.delete(
      Uri.parse(URL + '/warehouse/' + id.toString()),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete WarehousePlace');
  }
}
