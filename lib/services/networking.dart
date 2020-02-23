import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  NetworkHelper({this.url});

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      String data = response.body;
      return(jsonDecode(data));
    } else {
      print('Responce code: $statusCode');
    }

  }
}