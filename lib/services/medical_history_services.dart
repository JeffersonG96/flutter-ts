
import 'dart:async';

import 'package:app_login/global/environment.dart';
import 'package:app_login/models/historial_response.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MedicalHistoryServices with ChangeNotifier {



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
  return historialResp.medicalHistory;

  }

}