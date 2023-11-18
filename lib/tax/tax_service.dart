import 'package:openshelves/constants.dart';
import 'package:openshelves/tax/tax_model.dart';
import 'package:http/http.dart' as http;

Future<List<Tax>> getTaxes() async {
  return [
    Tax(id: 1, name: '0 %', rate: 0, standardRate: false),
    Tax(id: 2, name: '7 %', rate: 7, standardRate: false),
    Tax(id: 3, name: '19 %', rate: 19, standardRate: true),
  ];

  // var token = await getToken();
  // final response = await http.get(Uri.parse(URL + '/taxes'),
  //     headers: <String, String>{
  //       'Accept-Language': 'application/json',
  //       'Authorization': 'Bearer ' + token
  //     });
  // if (response.statusCode == 200) {
  //   return Tax.fromJsonList(jsonDecode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load taxes');
  // }
}
