import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';

Future<WarehousePlace> storeWarehousePlace(
    WarehousePlace warehousePlace) async {
  var token = await getToken();
  final response = await http.post(Uri.parse(URL + '/warehouseplace'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(warehousePlace));

  if (response.statusCode == 200) {
    return WarehousePlace.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store product');
  }
}

Future<List<WarehousePlace>> getWarehousePlaces(    ) async {
  var token = await getToken();
  final response = await http.get(Uri.parse(URL + '/warehouseplaces'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<WarehousePlace>.from(
        l.map((model) => WarehousePlace.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load warehouses');
  }
}

Future deleteWarehousePlace(int id) async {
  var token = await getToken();
  final response = await http.delete(
      Uri.parse(URL + '/warehouseplace/' + id.toString()),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete Warehouse');
  }
}

Future<WarehousePlace> getWarehousePlace(int id) async {
  var token = await getToken();
  final response = await http.get(
      Uri.parse(URL + '/warehouseplace/' + id.toString()),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    return WarehousePlace.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load prodWarehouseuct');
  }
}
