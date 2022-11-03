import 'package:app_login/helpers/mostrar_alerta.dart';
import 'package:app_login/pages/pages.dart';
import 'package:app_login/providers/providers.dart';
import 'package:app_login/witgets/boton_azul.dart';
import 'package:app_login/witgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NewAlertPage extends StatefulWidget {

  @override
  State<NewAlertPage> createState() => _NewAlertPageState();
}

class _NewAlertPageState extends State<NewAlertPage> {

  final _enfermedad = TextEditingController();
  final _medicamento = TextEditingController();

  bool switchNewAlert = false;
  bool switchDelete = false;

  bool check1H = false;
  bool check4H = false;
  bool check8H = false;

  int time = 0;

  @override
  Widget build(BuildContext context) {

    final newAlertService = Provider.of<NewAlertService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Alerta'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
        
                // Switch(title: 'Eliminar alerta', subtitle: 'Datos',),
                Container(
                margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20) ),
                child: SwitchListTile.adaptive(
                  activeColor: Colors.indigo,
                  title: Text('Eliminar alerta', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  subtitle: Text('Datos'),
                  value: switchDelete , 
                  onChanged: (value){
                    switchNewAlert = false;
                  switchDelete = value;
                    setState(() {
                      if(value)
                      print('Eliminando alerta');
                  }); } ),
                  ),

                Container(
                margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20) ),
                child: SwitchListTile.adaptive(
                  activeColor: Colors.indigo,
                  title: Text('Crear alerta', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  subtitle: Text('Active para crear alerta'),
                  value: switchNewAlert , 
                  onChanged: (value){
                  switchDelete = false;
                  switchNewAlert = value;
                    setState(() {
            
                  }); } ),
                  ),
        
                  Container(
                    margin: const EdgeInsets.only(left: 90, right: 20, top: 10, bottom: 10),
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 3,),
                        const Text('Tiempo para recibir alertas', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),

                        CheckboxListTile(
                          title: const Text('Cada 1 hora', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500, fontSize: 18),),
                          activeColor: Colors.indigo,
                          value: check1H, 
                          onChanged: switchNewAlert ? (value) => setState(() {
                              check4H = false;
                              check8H = false;
                              time = 60;
                            check1H = value ?? false;
                            if(!check1H){time = 0;}
                            print('valor de check1: $check1H');
                          })
                          : null
                          ),
                        CheckboxListTile(
                          title: const Text('Cada 4 horas', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500, fontSize: 18),),
                          activeColor: Colors.indigo,
                          value: check4H, 
                          onChanged: switchNewAlert ? (value) => setState(() {
                            check1H = false;
                            check8H = false;
                            time = 240;
                            check4H = value ?? false;
                            if(!check4H){time = 0;}
                            
                            print('valor de check4: $check4H');
                           
                          })
                          : null
                          ),
                        CheckboxListTile(
                          title: const Text('Cada 8 horas', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500, fontSize: 18),),
                          activeColor: Colors.indigo,
                          value: check8H, 
                          onChanged: switchNewAlert ? (value) => setState(() {
                            check1H = false;
                            check4H = false;
                            time =  480;
                            check8H = value ?? false;
                            if(!check8H){time = 0;}
                            print('valor de check8: $check8H');
                          })
                          : null
                          ),
        
                      ]),
                      decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20) ),
                  ),
                  
                CustomInput(
                icon: Icons.add_circle_outline, 
                placeholder: 'Describa el tipo de enfermedad', 
                textController: _enfermedad,
                isPassword: false, 
                labelText: 'Enfermedad',
                ),
                const SizedBox(height: 6),
        
                CustomInput(
                icon: Icons.note_add_outlined, 
                placeholder: 'Ingrese la dosis del medicamento', 
                textController: _medicamento,
                isPassword: false, 
                labelText: 'Medicamento',
                ),
        
                RaisedButton(
                elevation: 2,
                highlightElevation: 5,
                color: Color.fromRGBO(40, 53, 147, 1),
                shape: StadiumBorder(),
                onPressed:switchNewAlert
                ? () async {
                  //TODO enviar a la base de datos
                  FocusScope.of(context).requestFocus(FocusNode());
                  
                  if(time < 59 ){
                  mostrarAlerta(context, 'Elegir tiempo', 'Escoja un rango de tiempo para resivir alertas del estado de salud');
                  return;
                  }
                  if(_enfermedad.text.isEmpty) {
                    _enfermedad.text = 'Ninguna';
                  }
                  if(_medicamento.text.isEmpty){
                    _medicamento.text = 'Ninguno';
                  }

                  final alertaEnviada = await newAlertService.newAlert(time, _enfermedad.text , _medicamento.text);


                  if(alertaEnviada){
                  mostrarAlerta(context, 'Alerta creada', 'Se recibirá notificaciones cada ${time/60} horas');
                  } else {
                  mostrarAlerta(context, 'Error al crear alerta', 'Para mayor información contacte con el administrador');
                  }

                  check1H = false;  
                  check4H = false;
                  check8H = false;
                  time = 0;
                  _enfermedad.clear();
                  _medicamento.clear();
                  switchNewAlert = false;

                }
                : null,
                  child: Container(
                  width: 300,
                  height: 55,
                  child: Center(
                child: Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 18),)
                ), ), )
        
              ]),
          ),
        )
       ),
    );
  }
}




// class Switch extends StatefulWidget {

//   final String title;
//   final String subtitle;

//   const Switch({
//     Key? key, 
//     required this.title, 
//     required this.subtitle,
//   }) : super(key: key);

//   @override
//   State<Switch> createState() => _SwitchState();
// }

// class _SwitchState extends State<Switch> {

//    bool switchDelete = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20)
//       ),
//       child: SwitchListTile.adaptive(
//         activeColor: Colors.indigo,
//         title: Text(widget.title,),
//         subtitle: Text(widget.subtitle),
//         value: switchDelete , 
//         onChanged: (value){
//           switchDelete = value;
//           setState(() {
            
//           });
//         }
//         ),
//     );
//   }
// }