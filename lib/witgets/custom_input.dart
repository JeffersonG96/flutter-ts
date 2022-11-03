import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final String labelText;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    Key? key, 
  required this.icon, 
  required this.placeholder, 
  required this.textController, 
  this.keyboardType = TextInputType.text, 
  this.isPassword = false, 
  required this.labelText,
  
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  offset: Offset(0,5),
                  blurRadius: 4,
                )
              ]
              ),
            child: TextField(
              obscureText: this.isPassword,
              controller: this.textController,
              textAlignVertical: TextAlignVertical.bottom,
              autocorrect: false,
              keyboardType: this.keyboardType,
              decoration: InputDecoration(
                prefix: Icon(this.icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: this.placeholder,
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),
                 ),
            )
            ); 

  }
}