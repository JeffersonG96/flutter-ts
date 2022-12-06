import 'package:app_login/providers/auth_mqtt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authMqtt = Provider.of<AuthMqtt>(context);
    double levelBattery = authMqtt.battery;
    String messageBody = 'Estado del paciente normal';
    int battery = 80;
    bool change = false;

    if(authMqtt.status == 'En el piso'){
      messageBody = 'Se detecto una caída';
      change = true;
    }
    var tempDouble = double.parse(authMqtt.temp);
    if(tempDouble > 99){
      messageBody = 'Temperatura corporal elevada';
      change = true;
    }
    var heartDouble = double.parse(authMqtt.heart);
    if(heartDouble > 99){
      messageBody = 'Frecuencia cardiaca alterada';
      change = true;
    }
    var spo2Double = double.parse(authMqtt.spo2);
    if(spo2Double > 99){
      messageBody = 'Saturación de oxígeno inestable';
      change = true;
    }
    if(levelBattery>3.95){ battery = 100;}
    if(levelBattery>3.85&&levelBattery<3.94){ battery = 80;}
    if(levelBattery>3.75&&levelBattery<3.84){ battery = 60;}
    if(levelBattery>3.65&&levelBattery<3.74){ battery = 40;}
    if(levelBattery>3.55&&levelBattery<3.64){ battery = 20;}
    if(levelBattery>3.45&&levelBattery<3.54){ battery = 10;}
    if(levelBattery>3.35&&levelBattery<3.44){ battery = 5;}
    if(levelBattery<3.34){ battery = 0;}

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
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                  child: Icon(Icons.add_alert_outlined, color: change ? Colors.red : Colors.indigo,)),
                const Text('Notificaciones de emergencia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(width: 22,),
                const Icon(Icons.battery_0_bar_sharp, color: Colors.indigo, size: 23),
                Text("$battery%", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), ),
              ],
            ),
            const SizedBox(height: 15),
            Text(messageBody, style: TextStyle(color: change ? Colors.red : Colors.indigo, fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 15),
          ],
        ),
        
      ),
    );
  }
}