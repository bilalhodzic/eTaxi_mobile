import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

const realDeviceUri = 'https://192.168.1.108:45455/';
const localUri = '10.0.2.2:7152';
const googleApiKey = 'AIzaSyBllt8BR5FXxa6kmBRODoh08Rg__uQ3sCA';

class ApiModels {
  String apiUrl = localUri;

  Future postRequest({required String url, Object data = const {}}) async {
    final dataJson = jsonEncode(data);

    final uri = Uri.https(apiUrl, url);
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: dataJson);
    return response;
  }

  Future getRequest(
      {required String url, Map<String, dynamic>? queryParams}) async {
    final uri = Uri.https(apiUrl, url, queryParams);
    print(uri);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
