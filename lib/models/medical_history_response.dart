// To parse this JSON data, do
//
//     final medicalHistory = medicalHistoryFromJson(jsonString);

import 'dart:convert';

MedicalHistory medicalHistoryFromJson(String str) => MedicalHistory.fromJson(json.decode(str));

String medicalHistoryToJson(MedicalHistory data) => json.encode(data.toJson());

class MedicalHistory {
    MedicalHistory({
      required  this.userId,
      required  this.status,
      required  this.range,
      required this.counter,
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
    double temperatura;
    double frecuenciaC;
    double spO2;
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
        temperatura: json["temperatura"] + 0.0,
        frecuenciaC: json["frecuenciaC"] + 0.0,
        spO2: json["spO2"] + 0.0,
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
