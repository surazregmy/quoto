import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});
  String url;

  Future getData() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data.replaceAll(r"\'", "'").replaceAll(r'\"', '"'));
      } else {
        print("Error in consumiing API");
        return ("Error in consuming API. Status Code: ${response.statusCode}");
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
