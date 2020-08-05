@JS()
library stringify;

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('JSON.stringify')
external String stringify(Object obj);

class HTTPDriver {
  static loadFromHTTP(query, variables) async {
    var url = 'https://foododeringsystem.herokuapp.com/admin/api';
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: "{$query, $variables}",
    );
    print('Response status: ${response.statusCode}');
    // var body = jsonDecode(response.body);
    var body = (response.body);
    // print('Response body: ${body['id']['insertedId']}');

    //  await http.read('https://todo-flutter-api.herokuapp.com/api/all');
    // var obj = await http.read('https://todo-flutter-api.herokuapp.com/api/all');
    // var ob = await jsonDecode(obj);
    print(body);

    return body;
  }
}
