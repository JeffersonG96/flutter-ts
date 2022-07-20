// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';



class AuthResource with ChangeNotifier{


  String global_alarmResource = '';
  // print('paso0');
  final auth = {
    'username': 'jeffersong',
    'password': 'jg0411'
  };

  Future listResource() async{
String user = 'jeffersog';
String pass = 'jg0411';
String userpass = 'Basic' + base64Encode(utf8.encode('${user}:${pass}'));

print(userpass);

  
  final uri = Uri.parse('${Environment.apiEmqx}/$auth');
  final resp = await http.get(uri);

  print(resp.statusCode);
  print(resp.body);

  }
}