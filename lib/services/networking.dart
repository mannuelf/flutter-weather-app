import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Client client = Client();

  Future getData() async {
    Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      throw 'Data fetch error: ${response.statusCode}';
    }
  }
}
