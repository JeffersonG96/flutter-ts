
import 'package:app_login/pages/chart.dart';
import 'package:app_login/pages/chart_double_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_mqtt.dart';

class CardHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
   final authMqtt = Provider.of<AuthMqtt>(context);
   //convertir a String las variables 
   final temp = authMqtt.temp.toString();

    return Column(
      children:[ 
        Table(
        children: [
          TableRow(
            children: [
              _cardTable(titulo: 'Estabilidad',valorMqtt: authMqtt.status,icon: Icons.accessibility,unidad: 'Estable', fontSize: 23),
              _cardTable(titulo:'Temperatura', valorMqtt: temp, icon: Icons.thermostat, unidad: '°C', fontSize: 35,),
            ] ),
        ],
      ),
      
      // ChartSfCartesian(nameChart:'Temperatura', temp: authMqtt.temp.toDouble()),
      const CardChartHome(),

        Table(
          children: [
          TableRow(
            children: [
              _cardTable(titulo: 'Frecuencia Cardiaca', valorMqtt: authMqtt.heart.toString(), icon: Icons.favorite, unidad: 'BPM', fontSize: 35,),
              _cardTable(titulo: 'Pulsioxímetro',valorMqtt: authMqtt.spo2.toString(), icon: Icons.show_chart,unidad: 'SPO2', fontSize: 35,),
            ] ),
          ] ),

          const CardChartDouble(),
    
      ]
    );

  }
}

class _cardTable extends StatelessWidget {

  final String titulo;
  final String valorMqtt;
  final IconData icon;
  final String unidad;
  final double fontSize;

  const _cardTable({
    Key? key, 
    required this.titulo, 
    required this.valorMqtt, 
    required this.icon, 
    required this.unidad, 
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
         child: Card(      
            color: Colors.grey[300],
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),  //!Titulo
                Text(titulo,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
       
                SizedBox(height: 30,),
       
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [  //!valor mqtt
                    Text(valorMqtt,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold, fontSize: fontSize)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [  //!icono
                       Icon(icon, size: 55,color: Colors.indigo,),
                       SizedBox(height: 10,), //!unidad
                      Text(unidad,style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)) ,
                      ],
                    )
                    
                  ],
                ),             
            //*GRafica
            ],
            ),
          ),
       )
    );
  }
}



//*Chart
class CardChartHome extends StatelessWidget {

  const CardChartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authMqtt = Provider.of<AuthMqtt>(context); 
    final temp = authMqtt.temp.toString();

      return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
         child: Card(      
            color: Colors.grey[300],
            child:  ChartSfCartesian(),
         ) ) );
  }
}





class CardChartDouble extends StatelessWidget {

  const CardChartDouble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authMqtt = Provider.of<AuthMqtt>(context); 
    final temp = authMqtt.temp.toString();

      return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
         child: Card(      
            color: Colors.grey[300],
            child: ChartDouble(nameChart:'BPM y SPO2', heart: double.parse(authMqtt.heart), spo2: double.parse(authMqtt.spo2)),
         ) ) );
  }
}