import 'dart:convert';

import 'package:http/http.dart' as http;

const realDeviceUri = 'https://192.168.1.108:45455/';
const localUri = 'https://10.0.2.2:7152/';
const ngRokUri = 'https://5dad-178-236-86-58.eu.ngrok.io/';
const googleApiKey = 'AIzaSyBllt8BR5FXxa6kmBRODoh08Rg__uQ3sCA';

class ApiModels {
  // final apiUrl = 'https://localhost:44310/';

  String apiUrl = localUri;

  Future postRequest({required String url, Object data = const {}}) async {
    final dataJson = jsonEncode(data);

    final response = await http.post(Uri.parse('$apiUrl$url'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: dataJson);
    return response;
  }

  Future getRequest({required String url}) async {
    final response = await http.get(
      Uri.parse('$apiUrl$url'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
