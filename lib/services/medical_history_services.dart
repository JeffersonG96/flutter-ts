
import 'dart:async';
import 'dart:convert';

import 'package:app_login/global/environment.dart';
import 'package:app_login/models/historial_response.dart';
import 'package:app_login/models/medical_history_response.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedicalHistoryServices with ChangeNotifier {

  String enfermedad = 'Ninguna';
  bool status = false;

  Future<List<MedicalHistory>> getHistorial() async {
  
  final uri = Uri.parse('${ Environment.apiUrl}/data/medical_history');
  final resp = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '1111111' ,
      }
  );

  final historialResp = historialResponseFromJson(resp.body);
  print("historial: $historialResp");
  Map<String, dynamic> bodyHistorial = jsonDecode(resp.body);

  enfermedad = bodyHistorial['medicalHistory'][0]['enfermedad'];
  status = bodyHistorial['medicalHistory'][0]['status'];

  return historialResp.medicalHistory;

  }

}