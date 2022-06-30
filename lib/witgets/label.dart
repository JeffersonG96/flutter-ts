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
      child: Column(children:  <Widget>[
        const SizedBox(height: 10,),
        Text(this.subtitulo, style: const TextStyle(color: Colors.black87, fontSize:15, fontWeight: FontWeight.w400 ),),
        const SizedBox(height: 20,),
        GestureDetector(
          child: Text(this.titulo, style: const TextStyle(color: Colors.indigo, fontSize:20, fontWeight: FontWeight.w700),),
          onTap: (){
            Navigator.pushReplacementNamed(context, this.ruta);
          },
          ),
      ]),
      
    );
  }
}