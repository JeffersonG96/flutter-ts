import 'package:flutter/material.dart';
import 'package:app_login/providers/providers.dart';
import 'package:provider/provider.dart';

class BarNavigator extends StatelessWidget {
  const BarNavigator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //*Optener selected Menu Option Provider
    final barProvider = Provider.of<BarProvider>(context);

    return  BottomNavigationBar(
      currentIndex: barProvider.selectedMenuOpt,   //Seleccionar
      onTap: (int i) => barProvider.selectedMenuOpt =  i,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment),
        label: 'Historial'
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Perfil'
        )
      ]
      );
  }
}

