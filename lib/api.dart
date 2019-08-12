import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AuthenticationService {
  final String getApiUrl = 'http://192.168.8.101:1136/v2/';

  Future<dynamic> authenticate(Object payload) async {
    // print(convert.jsonDecode(payload));
    final dynamic response = await http.post(
        getApiUrl + 'init_plugin_transaction',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: convert.jsonEncode(payload));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = convert.jsonDecode(response.body);
      jsonResponse['statusCode'] = response.statusCode;
      return jsonResponse;
    } else {
      const dynamic jsonResponse = '';
      jsonResponse['statusCode'] = response.statusCode;
      jsonResponse['message'] = 'error';
      return jsonResponse;
    }
  }
}
