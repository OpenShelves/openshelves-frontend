import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouseplace/inventory_level_model.dart';
import 'package:openshelves/warehouseplace/inventory_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';

Future<Inventory> storeInventory(Inventory inventory) async {
  var token = await getToken();
  final response = await http.post(Uri.parse(URL + '/inventory'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(inventory));

  if (response.statusCode == 200 || response.statusCode == 201) {
    return Inventory.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store inventory');
  }
}

Future<List<InventoryLevel>> getInventoryLevels(int inventoryId) async {
  var token = await getToken();
  final response = await http.get(
      Uri.parse(URL + '/inventory/' + inventoryId.toString() + '/products'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<InventoryLevel>.from(
        l.map((model) => InventoryLevel.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load InventoryLevel');
  }
}
