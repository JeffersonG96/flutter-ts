import 'package:app_login/witgets/witgets.dart';
import 'package:flutter/material.dart';


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
            ),
          CustomInput(
            icon: Icons.lock_outline, 
            placeholder: 'Contraseña', 
            textController: passCtrl,
            isPassword: true,
            ),
          
        BotonInOutPut(
          text: 'Ingresar', 
          onPressd: () => {
            print(emailCtrl.text),
            print(passCtrl.text)

          }
          ),

        ],
      ),
      
    );
  }
}
