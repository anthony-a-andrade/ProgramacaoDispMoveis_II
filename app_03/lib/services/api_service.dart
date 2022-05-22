import 'package:http/http.dart' as http;
import 'package:app_03/services/log_service.dart';

var _uri = Uri.https("api.hgbrasil.com", "/finance", { "key": "b15461b6" });

class APIService {
  static Future<String?> getBody() async {
    try {
      Logger.info("API-REQUEST $_uri");
      http.Response response = await http.get(_uri);
      Logger.info("API-REQUEST-SUCCESS");
      return response.body;
    } catch (e) { 
      Logger.error("ERROR-API-REQUEST " + e.toString()); 
      throw Exception(e.toString());
    }
  }
}