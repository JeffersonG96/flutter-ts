import 'dart:convert';
import 'package:app_login/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_login/models/usuario.dart';
import 'package:app_login/global/environment.dart';
import 'package:app_login/models/login_response.dart';
import 'package:provider/provider.dart';


class AuthService with ChangeNotifier{

  Usuario? usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  //get y set para bloquear el boton "ingresar" mientras esta autenticando
  bool get autenticando => this._autenticando;
  //recibe estado de "valor"
  set autenticando (bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

//Getter del token de forma estatica 
static Future<String?> getToken() async {
  final _storage = new FlutterSecureStorage();
  final token = await _storage.read(key: 'token');
  return token;
}

static Future<void> deleteToken() async {
  final _storage = new FlutterSecureStorage();
  await _storage.delete(key: 'token');
}

//LOGIN A LA APP 
//Future va regresa <bool> 
Future<bool> login(String email, String password) async {

  this.autenticando = true; //deshabilita botón

  final data = {
    'email': email,
    'password': password
  };

  final uri = Uri.parse('${ Environment.apiUrl }/login');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
  );

  //Confirmar si la peticion se hizo correctamente 
  this.autenticando = false;  //habilita botón 
  if ( resp.statusCode == 200) {
    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;

    //* Guardar toquen en lugar seguro
    await this._guardarToken(loginResponse.token);

    return true;
  } else {
    return false;
  }
} //login



//Future para registrar nuevos usuarios.
Future register(String nombre,String email, String password) async{
  this.autenticando = true; //deshabilita botón

  final data = {
    'nombre': nombre,
    'email': email,
    'password': password
  };

  final uri = Uri.parse('${ Environment.apiUrl }/login/new');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
  );

  //Confirmar si la peticion se hizo correctamente 
  this.autenticando = false;  //habilita botón 
  if ( resp.statusCode == 200) {
    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;

    //* Guardar toquen en lugar seguro
    await this._guardarToken(loginResponse.token);
    print('Creado correctamente');

    return true;
  } else {
    final respBody = jsonDecode(resp.body);
    return respBody["msg"] ?? 'Ingresar correctamente sus datos';
  }
}//register


//Verificar token en dispositivo y en la base de datos
Future<bool> estaLogeado() async {

  final token = await this._storage.read(key: 'token') ?? '';
  
  final uri = Uri.parse('${ Environment.apiUrl }/login/renew');
  final resp = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
  );

//  _storage.delete(key: 'token'); 

  // print('PARA ELIMINAR ${token}');

  //Confirmar si la peticion se hizo correctamente 
  if ( resp.statusCode == 200) {
    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;

    //* Guardar toquen en lugar seguro
    await this._guardarToken(loginResponse.token);

    return true;
  } else {
    this.logout();
    return false;
  }

} //estaLogeado



//*ENVIAR ID 
Future<Map> sendId() async{

  final token = await this._storage.read(key: 'token') ?? '';

  final data = {
    'uid': usuario?.uid ?? '121212',
  };

  final uri = Uri.parse('${ Environment.apiUrl }/login/find');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
  );

  final Map<String, dynamic> decodeData =json.decode(resp.body);
  // final username = decodeData['username'];
  // print(username);
  if(resp.statusCode == 200){
    print('ENVIADO ID');

    return decodeData;
  }
  return {'uid': '121212', 'username': 'na', 'password': 'na'};
}



//*enviar token a mongo
Future sendDeviceId(String tokenDeviceId) async{

  final data = {
    'uid': usuario?.uid ?? '121212',
    'deviceId': tokenDeviceId,
  };

  final token = await this._storage.read(key: 'token') ?? '';

  final uri = Uri.parse('${ Environment.apiUrl }/login/receive-deviceId');
  final resp = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
  );

  //Confirmar si la peticion se hizo correctamente 

  if ( resp.statusCode == 200) {
    print('tokenen device en base de datos');
    return true;
  } 
  return false;
}//register




//Guardar Token en storage 
Future _guardarToken(String token) async {
// Write token en storage
return await _storage.write(key: 'token', value: token);
} //_guardarToken

  //Eliminar token de storage
Future logout() async {
  await _storage.delete(key: 'token');
}

}

