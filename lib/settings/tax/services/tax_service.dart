import 'dart:convert';

import 'package:openshelves/constants.dart';

import 'package:http/http.dart' as http;
import 'package:openshelves/settings/tax/models/tax_model.dart';

// Future<DocumentRowModel> storeDocumentRow(DocumentRowModel documentRow) async {
//   var token = await getToken();
//   await storage.read(key: 'selectedServer').then((value) {
//     if (value != null) {
//       URL = value;
//     }
//   });
//   final response = await http.post(Uri.parse(URL + '/documentrow'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer ' + token
//       },
//       body: jsonEncode(documentRow));

//   if (response.statusCode == 200) {
//     return DocumentRowModel.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to store document row');
//   }
// }

Future<List<Tax>> getTaxes() async {
  var token = await getToken();
  if (token == null) {
    throw Exception('No token');
  }
  final response =
      await http.get(Uri.parse(URL + '/taxrates'), headers: <String, String>{
    'Accept-Language': 'application/json',
    'Authorization': 'Bearer ' + token.toString()
  });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);

    return List<Tax>.from(l.map((model) {
      // print(Tax.fromJson(model));
      return Tax.fromJson(model);
    }));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
