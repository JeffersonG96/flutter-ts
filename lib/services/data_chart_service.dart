
import 'package:app_login/global/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DataChartService with ChangeNotifier {

  var responseData = '';
  final _storage = new FlutterSecureStorage();

   static Future<String?> getToken() async {
  final _storage = new FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  return token;
}

  Future getDataChart() async {

  try {
    
  final token = await this._storage.read(key: 'token') ?? '1211';
  print('este es el token $token');
  final uri = Uri.parse('${ Environment.apiUrl}/datachart');
  final resp = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      }
  );

  responseData = resp.body;
  return responseData;

  } catch (e) {
    print(e);
  } 
  }


}