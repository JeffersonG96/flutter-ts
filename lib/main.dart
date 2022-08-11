import 'package:app_login/emqx/emqx-api.dart';
import 'package:app_login/global/environment.dart';
import 'package:app_login/providers/providers.dart';
import 'package:app_login/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final Color? colorBody =    Color(0xffF2F2F2);//Colors.grey[200];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BarProvider()),
        ChangeNotifierProvider(create: (_) => AuthResource()),
        ChangeNotifierProvider(create: (_) => AuthMqtt(), lazy: false),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adultos Mayores',
        initialRoute: 'loading',  //loading 
        routes: appRoutes,
        

//theme
  theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: colorBody,

        appBarTheme: const AppBarTheme(
          // color: Colors.red,
          color: Colors.indigo,
          elevation: 0,
          
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorBody,
          selectedIconTheme: IconThemeData(color: Color.fromRGBO(40, 53, 147, 1)),
          selectedItemColor: Color.fromARGB(255, 5, 5, 5),
        ),
      ),

      ),
    );
  }
}
