import 'package:app_login/models/historial_response.dart';
import 'package:app_login/services/medical_history_services.dart';
import 'package:app_login/witgets/boton_azul.dart';
import 'package:app_login/witgets/box_historial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistorialPage extends StatefulWidget {

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> with TickerProviderStateMixin {

  late MedicalHistoryServices medicalHistoryServices;


  List<BoxHistorial> _texto = [ ];

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    this.medicalHistoryServices = Provider.of<MedicalHistoryServices>(context,listen: false);

    _cargarHistorial();
  }

  void _cargarHistorial() async {
    List <MedicalHistory> historial = await this.medicalHistoryServices.getHistorial();
    print("historial: ${historial.length}");

    final listHistorial = historial.map((h) => BoxHistorial(
      enfermedad: h.enfermedad, 
      fecha: DateTime.fromMillisecondsSinceEpoch(h.time), 
      frecuenciaC: h.frecuenciaC + 0.0, 
      spO2: h.spO2 + 0.0, 
      temp: h.temperatura + 0.0,
      ));

      setState(() {
        _texto.insertAll(0, listHistorial);
      });
    
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[

            const Divider(height: 3,),

            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _texto.length,
                itemBuilder: (_,i) => _texto[i],
                ) ),
            
            const Divider(height: 5,),

            Container(
              width: 200,
              child: BotonInOutPut(text:'Nueva Alerta' , onPressd: (){
                Navigator.pushNamed(context, 'alerta');
              } ),
            )

          ]),
        )
      );
  }
}