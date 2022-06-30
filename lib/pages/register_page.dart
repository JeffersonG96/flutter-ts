import 'package:app_login/witgets/witgets.dart';
import 'package:flutter/material.dart';

//!fffffffffffffffffffff
class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: GestureDetector(
                  onTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus){
          FocusManager.instance.primaryFocus!.unfocus(); 
          } },
            child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                
                Logo(titulo: 'Registrar',),
                _Form(),
                Labels(ruta: 'login',titulo: 'Ingresar con tu cuenta', subtitulo: '¿Ya tienes cuenta?',),
               const Text('Términos y condiciones de Uso', style: TextStyle(fontWeight: FontWeight.w300),)
              ],),
            ),
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
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.only(top: 35),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
            
            CustomInput(
              icon: Icons.person_outline_rounded, 
              placeholder: 'Nombre', 
              textController: nameCtrl,
              keyboardType: TextInputType.text,
              ),
            CustomInput(
              icon: Icons.person_outline_outlined, 
              placeholder: 'Apellido', 
              textController: lastNameCtrl,
              keyboardType: TextInputType.text,
              ),
            CustomInput(
              icon: Icons.mail_outline_outlined, 
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
            text: 'Registrar', 
            onPressd: () {
              print(passCtrl);
            }
            ),
    
          ],
        ),
        
      );
  }
}
