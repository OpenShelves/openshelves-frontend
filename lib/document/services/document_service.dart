import 'dart:convert';

import 'package:openshelves/constants.dart';
import 'package:openshelves/document/models/document_model.dart';
import 'package:openshelves/document/models/document_row_model.dart';

import 'package:http/http.dart' as http;

Future<DocumentRowModel> storeDocumentRow(DocumentRowModel documentRow) async {
  var token = await getToken();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  final response = await http.post(Uri.parse(URL + '/documentrow'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(documentRow));

  if (response.statusCode == 200) {
    return DocumentRowModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store document row');
  }
}

Future<Document> storeDocument(Document document) async {
  var token = await getToken();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  final response = await http.post(Uri.parse(URL + '/document'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(document));

  if (response.statusCode == 200 || response.statusCode == 201) {
    return Document.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store document row');
  }
}

Future<List<Document>> getAllDocuments() async {
  var token = await getToken();
  await storage.read(key: 'selectedServer').then((value) {
    if (value != null) {
      URL = value;
    }
  });
  final response = await http.get(Uri.parse(URL + '/documents'),
      headers: <String, String>{
        'Accept-Language': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    return List<Document>.from(l.map((model) => Document.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
