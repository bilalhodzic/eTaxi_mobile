import 'dart:convert';

import 'package:http/http.dart' as http;

const googleApiKey = 'AIzaSyBllt8BR5FXxa6kmBRODoh08Rg__uQ3sCA';
const localhost = 'localhost:7152';

class ApiModels {
  String apiUrl = localhost;

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

  Future putRequest({required String url, Object data = const {}}) async {
    final dataJson = jsonEncode(data);

    final uri = Uri.https(apiUrl, url);
    final response = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: dataJson);
    return response;
  }

  Future deleteRequest({required String url, Object data = const {}}) async {
    final dataJson = jsonEncode(data);

    final uri = Uri.https(apiUrl, url);
    final response = await http.delete(uri,
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

  Future addFile(String filePath, int userId,
      {String? type, int? feedbackId}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.https(
        apiUrl,
        "api/File",
      ),
    );

    request.headers["Content-Type"] = "multipart/form-data";
    request.headers["accept"] = "text/plain";

    request.files.add(await http.MultipartFile.fromPath('File', filePath));

    request.fields["UserId"] = userId.toString();
    request.fields["Type"] = type ?? '';
    if (feedbackId != null)
      request.fields["FeedbackId"] = feedbackId.toString();

    http.Response res = await http.Response.fromStream(await request.send());
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw jsonDecode(res.body)['title'];
    }
  }
}
