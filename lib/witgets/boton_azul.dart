import 'package:flutter/material.dart';

class BotonInOutPut extends StatelessWidget {

final String text;
final Function onPressd;

  const BotonInOutPut({
    Key? key, 
  required this.text, 
  required this.onPressd
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
     elevation: 2,
     highlightElevation: 5,
     color: Color.fromRGBO(40, 53, 147, 1),
     shape: StadiumBorder(),
     onPressed:() => this.onPressd(),
     child: Container(
       width: double.infinity,
       height: 55,
       child: Center(
         child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),)
         ),
       ),
     );
  }
}