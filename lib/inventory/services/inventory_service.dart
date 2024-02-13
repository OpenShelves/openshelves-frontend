import 'dart:convert';

import 'package:openshelves/constants.dart';
import 'package:openshelves/warehouseplace/models/inventory_change_model.dart';
import 'package:http/http.dart' as http;

Future<List<InventoryChange>> getInventoryChange(
    String warehousePlaceId) async {
  var token = await getToken();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  final response = await http.get(
      Uri.parse(URL + '/inventory-changes/$warehousePlaceId'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<InventoryChange>.from(
        l.map((model) => InventoryChange.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
