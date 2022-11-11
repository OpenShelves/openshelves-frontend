import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_model.dart';

Future<Product> storeProduct(Product product) async {
  final response = await http.post(Uri.parse(URL + '/product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product));

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store product');
  }
}

Future<List<Product>> getProducts() async {
  var token = await getToken();
  final response = await http.get(Uri.parse(URL + '/products'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<Product>.from(l.map((model) => Product.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}

Future<List<Product>> searchProducts(String query) async {
  var token = await getToken();
  final response = await http.get(
      Uri.parse(URL + '/products/search?query=' + query),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<Product>.from(l.map((model) => Product.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
