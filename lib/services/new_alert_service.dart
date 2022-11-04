import 'package:app_login/models/body_alert_response.dart';
import 'package:app_login/models/historial_response.dart';
import 'package:app_login/models/medical_history_response.dart';
import 'package:app_login/models/new_alert_response.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app_login/global/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewAlertService with ChangeNotifier {

Future newAlert(int range,String enfermedad, String medicamento) async{


  final data = {
    'status': true,
    'range': range,
    'counter': 0,
    'enfermedad': enfermedad,
    'medicamento': medicamento
  };

  final uri = Uri.parse('${ Environment.apiUrl }/data/new_alert');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '1111111' ,
      }
  );

  if(resp.statusCode == 200){
    final history = newAlertFromJson(resp.body);
    return true;
  }

return false;

}



  Future <bool> updateAlert(bool status) async {
  
    final data = {
    'status': status,
  };
  
  final uri = Uri.parse('${ Environment.apiUrl}/data/update_alert');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '1111111' ,
      }
  );

  if(resp.statusCode == 200){
  return true;
  }

  return false;

  }



}