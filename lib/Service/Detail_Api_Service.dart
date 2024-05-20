
import 'package:http/http.dart'as http;
import 'package:tastybud/Models/Detail_Model.dart';
class ApiService {
  Future<List<Details>> getApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.1.5:8080/viewdata");
    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return detailsFromJson(response.body);

    } else {
      return[];
    }
  }
}