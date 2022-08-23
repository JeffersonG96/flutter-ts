
import 'package:app_login/global/environment.dart';
import 'package:app_login/models/data_chart_response.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DataChartService with ChangeNotifier {
   final _storage = new FlutterSecureStorage();

   static Future<String?> getToken() async {
  final _storage = new FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  return token;
}

  Future<List<Msg>> getDataChart() async {
    
  final token = await this._storage.read(key: 'token') ?? '1211';
  print('este es el token $token');
  final uri = Uri.parse('${ Environment.apiUrl}/datachart');
  final resp = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      }
  );

  //  if ( resp.statusCode == 200){
  final dataChartResponse = dataChartResponseFromJson(resp.body);
  print('llego data chart');
  return dataChartResponse.msg;
   

  }




}