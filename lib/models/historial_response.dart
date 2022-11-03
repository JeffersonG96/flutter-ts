// To parse this JSON data, do
//
//     final historialResponse = historialResponseFromJson(jsonString);

import 'dart:convert';

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

class MedicalHistory {
    MedicalHistory({
      required  this.userId,
      required  this.status,
      required  this.range,
      required  this.counter,
      required  this.enfermedad,
      required  this.medicamento,
      required  this.temperatura,
      required  this.frecuenciaC,
      required  this.spO2,
      required  this.time,
      required  this.createdAt,
      required  this.updatedAt,
    });

    String userId;
    bool status;
    int range;
    int counter;
    String enfermedad;
    String medicamento;
    int temperatura;
    int frecuenciaC;
    int spO2;
    int time;
    DateTime createdAt;
    DateTime updatedAt;

    factory MedicalHistory.fromJson(Map<String, dynamic> json) => MedicalHistory(
        userId: json["userId"],
        status: json["status"],
        range: json["range"],
        counter: json["counter"],
        enfermedad: json["enfermedad"],
        medicamento: json["medicamento"],
        temperatura: json["temperatura"],
        frecuenciaC: json["frecuenciaC"],
        spO2: json["spO2"],
        time: json["time"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "status": status,
        "range": range,
        "counter": counter,
        "enfermedad": enfermedad,
        "medicamento": medicamento,
        "temperatura": temperatura,
        "frecuenciaC": frecuenciaC,
        "spO2": spO2,
        "time": time,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
