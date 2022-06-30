import 'package:flutter/material.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20), bottomRight: Radius.circular(20) ),
        ),
        width: double.infinity,
        height: 120,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Icon(Icons.add_alert_outlined, color: Colors.indigo,)),
                Text('Notificaciones de emergencia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            SizedBox(height: 15),
            Text('ESTO ES UNA EMERGENCIA',style: TextStyle(color: Colors.red[300], fontSize: 20, fontWeight: FontWeight.w500),),
          ],
        ),
        
      ),
    );
  }
}