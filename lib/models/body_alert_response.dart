// To parse this JSON data, do
//
//     final bodyAlert = bodyAlertFromJson(jsonString);

import 'dart:convert';

BodyAlert bodyAlertFromJson(String str) => BodyAlert.fromJson(json.decode(str));

String bodyAlertToJson(BodyAlert data) => json.encode(data.toJson());

class BodyAlert {
    BodyAlert({
      required  this.status,
      required  this.range,
      required  this.counter,
      required  this.enfermedad,
      required  this.medicamento,
    });

    bool status;
    int range;
    int counter;
    String enfermedad;
    String medicamento;

    factory BodyAlert.fromJson(Map<String, dynamic> json) => BodyAlert(
        status: json["status"],
        range: json["range"],
        counter: json["counter"],
        enfermedad: json["enfermedad"],
        medicamento: json["medicamento"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "range": range,
        "counter": counter,
        "enfermedad": enfermedad,
        "medicamento": medicamento,
    };
}
