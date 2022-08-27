//*SHA1       EF:24:BA:84:25:7E:BA:BA:B8:DE:24:81:1C:47:56:2A:77:5D:C9:AC

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsService {
  // identifica el id del proyecto 
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  //*send title and body 


  static Future _backgroundHandler(RemoteMessage message) async {
    print('background Handler ${message.messageId}');
    _messageStream.add(message.notification?.body ?? 'No title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('on Message Handler ${message.messageId}');
     _messageStream.add(message.notification?.body ?? 'No title');
  } 

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('on Message Open App ${message.messageId}');
     _messageStream.add(message.notification?.body ?? 'No title');
  }

  
  static Future initializeApp() async {

    await Firebase.initializeApp();
    //ALmacenar token
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN: $token');
    //!guardar este token en la base de datos con peticion http

    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

  }

  static closeStreams(){
    _messageStream.close();
  }

}