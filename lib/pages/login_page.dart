import 'package:app_login/helpers/mostrar_alerta.dart';
import 'package:app_login/providers/providers.dart';
import 'package:app_login/services/push_notifications_service.dart';
import 'package:app_login/witgets/witgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF2F2F2), //Colors.grey[300],
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
              
              const Logo(titulo: 'Signos Vitales'),
              _Form(),
              const Labels(ruta: 'register',titulo: 'Crea una cuenta ahora!', subtitulo: '¿No tienes cuenta?'),
              const SizedBox(height: 5,),
             const Text('Términos y condiciones de Uso', style: TextStyle(fontWeight: FontWeight.w400),)
            ],),
          ),
        ),
      )
   );
  }
}


//////////////////////////
class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService= Provider.of<AuthService>(context);  //Provider desde AuthService

    final authMqtt = Provider.of<AuthMqtt>(context);  //Provider desde AuthMqtt

    final barProvider = Provider.of<BarProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 35),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.person, 
            placeholder: 'Correo Electrónico', 
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress, 
            labelText: 'Correo',
            ),
          CustomInput(
            icon: Icons.lock_outline, 
            placeholder: 'Contraseña', 
            textController: passCtrl,
            isPassword: true, 
            labelText: 'Contraseña',
            ),
          
        BotonInOutPut(
          text: 'Ingresar', 
                    //revisar si a presionado el botón "Ingresar" 
          onPressd: authService.autenticando ? () => {}: () async {
            FocusScope.of(context).unfocus();
            final loginok = await authService.login(emailCtrl.text, passCtrl.text);

            if (loginok) {
              //*Navegar a la pantalla de HomeScreen

              //*ENVIAR ID
             final data = await authService.sendId();

             final mqttUsername = data['username'];
             final mqttPassword = data['password'];
             final uid = data['uid'];

              //ingresar a home
              Navigator.pushReplacementNamed(context, 'home');
              
              //?conectar al BROKER
              authMqtt.mqttConnect(uid, mqttUsername, mqttPassword);

              //*enviar token device
              final tokenDeviceId = PushNotificationsService.token ?? '';
              await authService.sendDeviceId(tokenDeviceId);
              
              barProvider.selectedMenuOpt = 0;

            } else {
              //Mostrar Alerta si las credenciales no son correctas 
              mostrarAlerta(context, 'Credenciales Incorrectas', 'Verifique correo electrónico o contraseña');
            }
          },
          ),

        ],
      ),
      
    );
  }
}


