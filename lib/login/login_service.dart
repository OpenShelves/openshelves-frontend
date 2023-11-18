import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';

Future<String> login(String email, String password) async {
  const storage = FlutterSecureStorage();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  final response = await http.post(Uri.parse(URL + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    storage.write(key: 'token', value: response.body);
    return '${json['success']['token']}';
  } else {
    throw Exception('Failed to Login');
  }
}
