// To parse this JSON data, do
//
//     final dataChartResponse = dataChartResponseFromJson(jsonString);

import 'dart:convert';

DataChartResponse dataChartResponseFromJson(String str) => DataChartResponse.fromJson(json.decode(str));

String dataChartResponseToJson(DataChartResponse data) => json.encode(data.toJson());

class DataChartResponse {
    DataChartResponse({
      required  this.ok,
      required  this.msg,
    });

    bool ok;
    List<Msg> msg;

    factory DataChartResponse.fromJson(Map<String, dynamic> json) => DataChartResponse(
        ok: json["ok"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    };
}

class Msg {
    Msg({
      required  this.userId,
      required  this.variable,
      required  this.value,
      required  this.createdAt,
      required  this.updatedAt,
    });

    String userId;
    String variable;
    int value;
    DateTime createdAt;
    DateTime updatedAt;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        userId: json["userId"],
        variable: json["variable"],
        value: json["value"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "variable": variable,
        "value": value,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
