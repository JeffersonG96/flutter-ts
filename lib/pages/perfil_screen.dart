import 'package:app_login/emqx/emqx-api.dart';
import 'package:app_login/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:app_login/pages/login_page.dart';
import 'package:app_login/providers/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //importar name and email
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    final authResource = Provider.of<AuthResource>(context);

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
                    //TODO desconectar del broker mqtt

                    // final route = MaterialPageRoute(
                    //   builder: (context) => LoginPage()
                    //   );
                    AuthService.deleteToken(); //borra token de secure storage
                    Navigator.pushReplacementNamed(context, 'login');
                  },),

                   ListTile(title: Text('PROBAR'), subtitle: Text(''),trailing: const Icon(Icons.logout),iconColor: Colors.indigo, onTap: () {

                    //!Salir de la cuenta **************
                    //TODO desconectar del broker mqtt

                    // final route = MaterialPageRoute(
                    //   builder: (context) => LoginPage()
                    //   );
                    print('TOCO PROBAR');
                    authResource.listResource();

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