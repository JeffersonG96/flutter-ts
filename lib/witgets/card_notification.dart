import 'package:app_login/providers/auth_mqtt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authMqtt = Provider.of<AuthMqtt>(context);
    String messageBody = 'Estado del paciente normal';
    bool change = false;

    if(authMqtt.status == 1){
      messageBody = 'Se detecto una caída';
      change = true;
    }
    if(authMqtt.temp > 99){
      messageBody = 'Temperatura corporal elevada';
      change = true;
    }
    if(authMqtt.heart > 99){
      messageBody = 'Frecuencia cardiaca alterada';
      change = true;
    }
    if(authMqtt.spo2 > 99){
      messageBody = 'Saturación de oxígeno inestable';
      change = true;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        decoration: BoxDecoration(
          color: change ? Colors.amber[300]: Colors.grey[300],
          borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight: Radius.circular(20) ),
        ),
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            Row(
              children:  [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Icon(Icons.add_alert_outlined, color: change ? Colors.red : Colors.indigo,)),
                const Text('Notificaciones de emergencia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            const SizedBox(height: 15),
            Text(messageBody, style: TextStyle(color: change ? Colors.red : Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),),
          ],
        ),
        
      ),
    );
  }
}