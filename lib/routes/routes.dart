
import 'package:app_login/pages/home_screen.dart';
import 'package:app_login/pages/pages.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'home': (_) => HomeScreen(),
  'profil': (_) => ProfilScreen(),
};