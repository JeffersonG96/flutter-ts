import 'package:app_login/pages/pages.dart';
import 'package:app_login/providers/providers.dart';
import 'package:app_login/witgets/witgets.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Vitales', textAlign: TextAlign.center),
        leading: IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed:() {

          },
        ),
      ),
      body: _HomeScreenBody(), 

    bottomNavigationBar: BarNavigator(),

      );   
  }
}


class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //*Optener selected Menu Option Provider
    final barProvider = Provider.of<BarProvider>(context);

    final barIndex = barProvider.selectedMenuOpt;

    switch(barIndex) {
      case 0: 
      return SingleChildScrollView(
        child: Column(
          children: [
            CardNotification(),
            CardHome()],
      ),
      );

      case 1: 
      return ProfilScreen();

      default:
      return SingleChildScrollView(
        child: CardHome(),
      );
    }
  }
}

