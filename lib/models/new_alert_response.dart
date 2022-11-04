// To parse this JSON data, do
//
//     final newAlert = newAlertFromJson(jsonString);

import 'dart:convert';

import 'package:app_login/models/body_alert_response.dart';

NewAlert newAlertFromJson(String str) => NewAlert.fromJson(json.decode(str));

String newAlertToJson(NewAlert data) => json.encode(data.toJson());

class NewAlert {
    NewAlert({
      required  this.ok,
      required  this.msg,
      required  this.uId,
      required  this.bodyAlert,
    });

    bool ok;
    String msg;
    String uId;
    BodyAlert bodyAlert;

    factory NewAlert.fromJson(Map<String, dynamic> json) => NewAlert(
        ok: json["ok"],
        msg: json["msg"],
        uId: json["uId"],
        bodyAlert: BodyAlert.fromJson(json["bodyAlert"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "uId": uId,
        "bodyAlert": bodyAlert.toJson(),
    };
}


