import 'package:app_login/pages/home_screen.dart';
import 'package:app_login/pages/login_page.dart';
import 'package:app_login/providers/auth_mqtt.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context, snapshot) { 
          return const Center(
          child: Text('Cargado Datos...'),
           );
         },
      ),
   );
  }

Future checkLoginState(BuildContext context) async {

final authService = Provider.of<AuthService>(context, listen: false);

final autenticado = await authService.estaLogeado();

final authMqtt = Provider.of<AuthMqtt>(context, listen: false);

if (autenticado) {
  //TODO: conectar al broker mqtt

    final data = await authService.sendId();

    final mqttUsername = data['username'];
    final mqttPassword = data['password'];
    final uid = data['uid'];
    print('llega loading');
    print(mqttPassword);

    authMqtt.mqttConnect(uid, mqttUsername, mqttPassword);

  Navigator.pushReplacement(
    context, 
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => HomeScreen(),
      transitionDuration: const Duration(milliseconds: 0),
      )
    );
} else {
    Navigator.pushReplacement(
    context, 
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => LoginPage(),
      transitionDuration: const Duration(milliseconds: 0),
      )
    );
}


}
}