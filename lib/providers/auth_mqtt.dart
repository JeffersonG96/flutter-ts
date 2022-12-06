import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


  //*COnectar al broker
  // authMqtt.mqttConnect();
  //?Desconectar del broker
  // authMqtt.onDisconnected(); 

class AuthMqtt with ChangeNotifier {


Map dataMqtt = {};
String mainTopic = "";
String temp = "35";
String status = "";
String heart = "95.6";
String spo2 = "68.1";
double battery = 3.70;

final client = MqttServerClient.withPort('192.168.100.160', 'clientIdentifier', 1883);
var pongCount = 0;

Future mqttConnect(String id, String mqttUsername, String mqttPassword) async {

  client.logging(on: true);
  client.keepAlivePeriod=5;
  client.autoReconnect = true;
  client.onAutoReconnect = onAutoReconnect;
  client.onAutoReconnected = onAutoReconnected;
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;

  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  String random = generateRandomString(10);

    final connMess = MqttConnectMessage()
      .withClientIdentifier('app_$random')
      .authenticateAs(mqttUsername, mqttPassword)
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  print('Client connecting....');
  client.connectionMessage = connMess;
  
  try {
    await client.connect(); 
  } on NoConnectionException catch (e) {
    print(e.toString());
  }


if (client.connectionStatus!.state == MqttConnectionState.connected){
  print('Conectado correctamente');
} else {
  print('Coneccion fallida ${client.connectionStatus}');
  client.disconnect();
  exit(-1);
}

//suscribir
final topic = '$id/+/sdata';
client.subscribe(topic, MqttQos.atMostOnce);

client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> mqttReceivedMessage) { 
  final  recMess = mqttReceivedMessage[0].payload as  MqttPublishMessage;
  final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  mainTopic = mqttReceivedMessage[0].topic;
  // print('Datos de MQTT: $pt');

  final Map<String, dynamic>data = json.decode(pt);

  //*Temperatura
  final topicTemp = "$id/temp/sdata";
  if(mainTopic == topicTemp){
    temp = data['value'];  
  }

  //*Estabilidad
  final topicStatus = "$id/status/sdata";
    if(mainTopic == topicStatus){
    status = data['value'];  
    // print(('ESTADO: $status'));
  }

  //*
  final topicHeart = "$id/heart/sdata";
  if(mainTopic == topicHeart){
    heart = data['value'];
  }

  final topicSpo2 = "$id/spo2/sdata";
  if(mainTopic == topicSpo2){
    spo2 = data['value'];
  }
  
  final topicBattery = "$id/battery/sdata";
  if(mainTopic == topicBattery){
    battery = data['value'];
  }

dataMqtt = data;
notifyListeners();
});

}



void onConnected() {
  print('Conectado');
}

//Desconecta del Broker se debe pasar el topic
void onDisconnected() async{
  print('sigue');
if (client.connectionStatus!.state == MqttConnectionState.connected){
  print('DEsconectado......');
  const topic = 'test/casa';
  client.onUnsubscribed;

  await MqttUtilities.asyncSleep(5);
  print('Desconectandoo....');
  client.disconnect();
  print('Desconectado normalmente');
}

}


void onAutoReconnect() {
  print(
      'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
      // await client.connect(); 
}

/// The post auto re connect callback
void onAutoReconnected() {
  print(
      'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping...');
  pongCount ++ ;
  print(pongCount);
}

  String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

}