import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;

  const Logo({
    Key? key, 
    required this.titulo
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        width: 200,
          child:Column(
            children: <Widget>[
              
              Icon(Icons.volunteer_activism, size: 150, color: Color.fromRGBO(40, 53, 147, 1),),
              // Image(image: AssetImage('assets/vitals.jpg')),
              SizedBox(height: 20,),
              Text(titulo, style: TextStyle(fontSize: 30),)
            ],
          ) ,
      ),
    );
  }
}