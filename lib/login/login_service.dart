import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';

Future<String> login(String email, String password) async {
  final response = await http.post(Uri.parse(URL + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

  if (response.statusCode == 200) {
    // print(jsonDecode(response.body));
    Map<String, dynamic> json = jsonDecode(response.body);
    // print(json);
    return '${json['success']['token']}';
    // return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store product');
  }
}
