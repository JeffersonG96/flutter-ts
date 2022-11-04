// To parse this JSON data, do
//
//     final historialResponse = historialResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_login/models/medical_history_response.dart';

HistorialResponse historialResponseFromJson(String str) => HistorialResponse.fromJson(json.decode(str));

String historialResponseToJson(HistorialResponse data) => json.encode(data.toJson());

class HistorialResponse {
    HistorialResponse({
      required  this.ok,
      required  this.medicalHistory,
    });

    bool ok;
    List<MedicalHistory> medicalHistory;

    factory HistorialResponse.fromJson(Map<String, dynamic> json) => HistorialResponse(
        ok: json["ok"],
        medicalHistory: List<MedicalHistory>.from(json["medicalHistory"].map((x) => MedicalHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "medicalHistory": List<dynamic>.from(medicalHistory.map((x) => x.toJson())),
    };
}

