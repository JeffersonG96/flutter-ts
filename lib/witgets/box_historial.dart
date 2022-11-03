
import 'package:flutter/material.dart';

class BoxHistorial extends StatelessWidget {
 
 final String enfermedad;
 final double temp;
 final double frecuenciaC;
 final double spO2;
 final DateTime fecha;

  const BoxHistorial({
    Key? key, 
    required this.enfermedad, 
    required this.fecha, 
    required this.temp, 
    required this.frecuenciaC, 
    required this.spO2
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _boxHistorial(),
    );
  }

Widget _boxHistorial(){
return Align(
  alignment: Alignment.center,
  child: Container(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 10, left: 10,right: 10,top: 2),
    child: Column(
      children: [
         //!TEXTO DE  LA BASE DE DATOS .....................**********
        const Text('Estado del paciente', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),),
        const Text('', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 4,),),
        Text('Enfermedad actual:  $enfermedad.',  style: const TextStyle(fontWeight: FontWeight.w400 , fontSize: 17, ),textAlign: TextAlign.left,),
        Text('Temperatura Corporal:  $temp', style: const TextStyle(fontWeight: FontWeight.w400 , fontSize: 17, height:1.2),textAlign: TextAlign.left,),
        Text('Frecuencia Cardiaca:  $frecuenciaC', style: const TextStyle(fontWeight: FontWeight.w400 , fontSize: 17, height:1.3)),
        Text('Saturación de oxígeno:  $spO2', style: const TextStyle(fontWeight: FontWeight.w400 , fontSize: 17, height:1.3)),
        Text('Fecha:  $fecha', style: const TextStyle(fontWeight: FontWeight.w400 , fontSize: 17, height:1.3)),
      ]),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15)
      ),
  ),
   
);
}

}