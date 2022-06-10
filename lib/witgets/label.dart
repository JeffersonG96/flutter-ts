import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String titulo;
  final String subtitulo;

  const Labels({ Key? key, 
  required this.ruta, 
  required this.titulo, 
  required this.subtitulo 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text(this.subtitulo, style: TextStyle(color: Colors.black87, fontSize:15, fontWeight: FontWeight.w400 ),),
        SizedBox(height: 10,),
        GestureDetector(
          child: Text(this.titulo, style: TextStyle(color: Colors.blue[700], fontSize:20, fontWeight: FontWeight.bold),),
          onTap: (){
            Navigator.pushReplacementNamed(context, this.ruta);
          },
          ),
      ]),
      
    );
  }
}