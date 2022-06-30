
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Table(
      children:const [
        TableRow(
          children: [
            _cardTable(titulo: 'Estabilidad',valorMqtt: '-',icon: Icons.accessibility,unidad: 'Estable',),
            _cardTable(titulo:'Temperatura', valorMqtt: '36', icon: Icons.thermostat, unidad: '°C',),
          ] ),
        TableRow(
          children: [
            _cardTable(titulo: 'Frecuencia Cardiaca', valorMqtt: '70', icon: Icons.favorite, unidad: 'BPM',),
            _cardTable(titulo: 'Frecuencia Respiratoria',valorMqtt: '20', icon: Icons.show_chart,unidad: 'SPO2',),
          ] ),

        TableRow(
          children: [
            _cardTable(titulo: 'Presión Arterial',valorMqtt: '90',icon: Icons.timeline, unidad: 'mmHg',),
            _cardTable(titulo: 'Casa', valorMqtt: '100',icon: Icons.house_outlined, unidad: 'Normal',),
          ] ),
      ],
    );

  }
}

class _cardTable extends StatelessWidget {

  final String titulo;
  final String valorMqtt;
  final IconData icon;
  final String unidad;

  const _cardTable({
    Key? key, 
    required this.titulo, 
    required this.valorMqtt, 
    required this.icon, 
    required this.unidad,
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
                    Text(valorMqtt,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold, fontSize: 35)),
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
            ],
            ),
          ),
       )
    );
  }
}