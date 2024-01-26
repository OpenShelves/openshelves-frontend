import 'dart:convert';

import 'package:openshelves/constants.dart';
import 'package:openshelves/settings/user/models/user_model.dart';

import 'package:http/http.dart' as http;

Future<User> getUser() async {
  var token = await getToken();
  if (token == null) {
    throw Exception('No token');
  }
  final response =
      await http.get(Uri.parse(URL + '/user'), headers: <String, String>{
    'Accept-Language': 'application/json',
    'Authorization': 'Bearer ' + token.toString()
  });
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
