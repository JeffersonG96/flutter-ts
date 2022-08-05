import 'package:app_login/providers/auth_mqtt.dart';
import 'package:app_login/providers/bar_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_login/providers/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //importar name and email
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    final authMqtt = Provider.of<AuthMqtt>(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
      
            Icon(Icons.person_pin, size: 140,color: Colors.indigo,),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height *0.75,
                width: double.infinity,
                decoration: _boxDecoration(),
                child: ListView(
                  children: [
                    const SizedBox(height: 20,),

                  ListTile(title: Text('Cerrar sesión'), subtitle: Text(''),trailing: const Icon(Icons.logout),iconColor: Colors.indigo, onTap: () {

                    //!Salir de la cuenta **************

                    AuthService.deleteToken(); //borra token de secure storage
                    Navigator.pushReplacementNamed(context, 'login');
                    //TODO: desconectar del broker mqtt
                    authMqtt.onDisconnected();

                  },),

                   ListTile(title: Text('PROBAR'), subtitle: Text(''),trailing: const Icon(Icons.logout),iconColor: Colors.indigo, onTap: () async {

                    //!Salir de la cuenta **************
                    //TODO desconectar del broker mqtt

                    // final route = MaterialPageRoute(
                    //   builder: (context) => LoginPage()
                    //   );
                    print('TOCO PROBAR');
                    final idOk = await authService.sendId();
                    print('desde probar');
                    print(idOk);
                    
                    // authMqtt.mqttConnect();
                    

                    // authResource.listResource();
                    // update();


                  },),


                   const SizedBox(height: 10,),
                   const Divider(color: Colors.indigo, thickness: 1,),
                  ListTile(title: Text('Usuario'), subtitle: Text(usuario?.nombre ?? 'Sin Nombre'),trailing: const Icon(Icons.account_circle), iconColor: Colors.indigo,),
                   const Divider(color: Colors.indigo, thickness: 1,),
                  ListTile(title: Text('Correo'), subtitle: Text(usuario?.email ?? 'alguien@alguien.com'),trailing: const Icon(Icons.email_outlined), iconColor: Colors.indigo,),
                   const Divider(color: Colors.indigo, thickness: 1,),


                  ],
                ),
              ),
            )
            


            ],
          
        ),
          ),
      )
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  );
}