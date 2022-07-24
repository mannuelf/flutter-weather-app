import 'package:http/http.dart' show Client, Response;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper();

  Client client = Client();

  final root = 'https://api.openweathermap.org';
  final API_KEY = 'e14fe840c1768222dbc2a366f42b8909';

  Future getData(lat, lon) async {
    Response response = await client.get(
        Uri.parse('$root/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY'));
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
