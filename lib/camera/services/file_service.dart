import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openshelves/constants.dart';

uploadFile(String filename) async {
  var URL = '';
  const storage = FlutterSecureStorage();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  var token = await getToken();
  print(Uri.parse(URL + '/file'));
  var request = http.MultipartRequest('POST', Uri.parse(URL + '/file'));
  // request.

  // <String, String>{
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': 'Bearer ' + token
  // };
  request.files.add(http.MultipartFile('file',
      File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
      filename: filename.split("/").last));
  var res = await request.send();
  print(res.statusCode);
}
