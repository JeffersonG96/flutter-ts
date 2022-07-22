import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_login/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

  //*COnectar al broker
  // authMqtt.mqttConnect();
  //?Desconectar del broker
  // authMqtt.onDisconnected(); 

class AuthMqtt with ChangeNotifier {


Map dataMqtt = {};

final client = MqttServerClient.withPort('192.168.100.149', 'clientIdentifier', 1883);

Future mqttConnect(String id) async {

  client.keepAlivePeriod=60;
  client.autoReconnect = true;
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;

  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

    final connMess = MqttConnectMessage()
      .withClientIdentifier('flutterIDClient')
      .authenticateAs('user', 'root')
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
  print('Datos de MQTT: $pt');

final Map<String, dynamic>data = json.decode(pt);

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
}
}