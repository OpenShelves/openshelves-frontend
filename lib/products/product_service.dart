import 'dart:convert';

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
