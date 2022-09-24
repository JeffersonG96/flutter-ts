
import 'package:app_login/providers/providers.dart';
import 'package:app_login/routes/routes.dart';
import 'package:app_login/services/data_chart_service.dart';
import 'package:app_login/services/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color? colorBody =    Color(0xffF2F2F2);
//Colors.grey[200];

  // final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messangerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    //context
    PushNotificationsService.messagesStream.listen((message) {
      print('MyApp: $message');

      final snackBar = SnackBar(
        duration: const Duration(minutes: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.add_alert_outlined, color: Colors.white,),
            const SizedBox(width: 5),
            Expanded(child: 
            Text(message, textAlign: TextAlign.center,))
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        );
      messangerKey.currentState?.showSnackBar(snackBar);
     });
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BarProvider()),
        ChangeNotifierProvider(create: (_) => AuthMqtt()),
        ChangeNotifierProvider(create: (_) => DataChartService()),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adultos Mayores',
        initialRoute: 'loading',  //loading 
        // navigatorKey: , //para navegar a otra pantalla con notificaciones 
        scaffoldMessengerKey: messangerKey, //mostrar SNACKS
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

        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
          shape: StadiumBorder(),
          contentTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          behavior: SnackBarBehavior.floating,
        ),
      ),

      ),
    );
  }
}
