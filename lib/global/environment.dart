
//*SHA1       EF:24:BA:84:25:7E:BA:BA:B8:DE:24:81:1C:47:56:2A:77:5D:C9:AC

import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? 'http://192.168.100.160:3000/api' : 'http://192.168.100.160:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.100.160:3000' : 'http://192.168.100.160:3000';
  static String apiEmqx = 'http://192.168.100.149:8085/api/v4/resources/';
}


//credenciales para acceder a la api de EMQX
class AuthEmqx {
  static String username = 'admin';
  static String passwordE = 'jg0411';
}
