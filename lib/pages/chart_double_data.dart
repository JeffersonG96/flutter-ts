import 'dart:async';
import 'dart:convert';

import 'package:app_login/pages/chart.dart';
import 'package:app_login/services/data_chart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;


//Chart
class ChartDouble extends StatefulWidget {

  final  double heart;
  final  double spo2;
  final String nameChart;

  const ChartDouble({
    Key? key, 
    required this.nameChart, 
    required this.heart, 
    required this.spo2, 
    // required this.temp, 
  }) : super(key: key);

  @override
  State<ChartDouble> createState() => _ChartDoubleState();

}

class _ChartDoubleState extends State<ChartDouble> with AutomaticKeepAliveClientMixin {
  
  //  late Timer temp;
  List<HeartData> heartData = [];
  List<Spo2Data> spo2Data = [];
  late DataChartService dataChartService;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  double function = 10;
  int counter = 0;

  @override
  void initState() {

    heartData = getChartData();
    spo2Data = getChartData2();

    dataChartService = Provider.of<DataChartService>(context, listen: false);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, maximumZoomLevel:0.8); //hacer zoom con doble toque
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic( Duration(seconds: 12), updateDataSource);
    // Timer.periodic( Duration(seconds: 9), updateDataSource2);
    updateDataSource(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final double temp;
    super.build(context);
    return Container(
      width: double.infinity,
      height: 230,
      child: SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      title: ChartTitle(text: widget.nameChart, textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
      plotAreaBorderWidth: 2, //lineas del fondo del gráfico
      legend: Legend(isVisible: false),
      tooltipBehavior: _tooltipBehavior, //*muestra los datos de cada punto
      
      //<LiveData, DateTime>
      series: <ChartSeries>[
      LineSeries<HeartData, DateTime>(
      color: Colors.green,
      dataSource: heartData,
      name: 'BPM',
      xValueMapper: (HeartData sales, _) => sales.time,
      yValueMapper: (HeartData sales, _) => sales.value 
      ),


      LineSeries<Spo2Data, DateTime>(
      dataSource: spo2Data,
      name: 'SPo2 %',
      xValueMapper: (Spo2Data sales, _) => sales.time,
      yValueMapper: (Spo2Data sales, _) => sales.value 
      ),
      
      ],
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: DateTimeIntervalType.minutes,
        
        // minimum: DateTime.now(),
        // interval: 1,
        // title: AxisTitle(text: 'Segundos'),
        ),
      primaryYAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.outside,
        tickPosition: TickPosition.inside,
        isVisible: true, //ocultar línea y elementos del eje
        numberFormat: NumberFormat.simpleCurrency(name:'',decimalDigits: 1),
        maximum: 150,
        // title: AxisTitle(text: 'Temperatura'),
        
        ),
      ),
    );
    
  }


  void updateDataSource(heart) async {

    final jsonInt = await dataChartService.getDataChart();
    if(jsonInt != null){
    final dynamic jsonResponse = json.decode(jsonInt);
    heartData = []; //elimina toda la lista
    spo2Data = []; //elimina toda la lista
  
    for (Map<dynamic,dynamic> i in jsonResponse['heart']){
      print(i);
      //*Heart
      if(i['variable'] =='heart'){
        final Map<dynamic,dynamic> updateMap = i;
        final DateTime date1 = DateTime.fromMillisecondsSinceEpoch( updateMap['time']);
        final double date = updateMap['value'] +  0.0;
        updateMap['time'] = date1;
        updateMap['value'] = date;
        heartData.add(HeartData.fromJson(updateMap));
      }//if
      }

      //*Spo2
    for (Map<dynamic,dynamic> i in jsonResponse['spo2']) {
      
      if(i['variable'] =='spo2'){
        Map<dynamic,dynamic> updateMap = i;
        DateTime date1 = DateTime.fromMillisecondsSinceEpoch( updateMap['time']);
        double date = updateMap['value'] + 0.0;
        updateMap['time'] = date1;
        updateMap['value'] = date;
        spo2Data.add(Spo2Data.fromJson(updateMap)); 
      }
    }

    counter++;
    if(mounted){
     setState(() {
       counter;
     }); }
    // tempData.removeRange(0, lengthData);
  }
  }

  
  @override
  bool get wantKeepAlive => true;
  

}

//*Data Heart
List<HeartData> getChartData(){
  final List<HeartData> _chartDate = [
  ];
  return _chartDate;
}

class HeartData{
  HeartData(this.time, this.value);
  final DateTime time;
  final double value;

  factory HeartData.fromJson(Map<dynamic,dynamic> parsedJson){
    return HeartData(
      parsedJson['time'],
      parsedJson['value'],
    );
  }  }

//*Data SPo2
List<Spo2Data> getChartData2(){
  final List<Spo2Data> _chartDate = [
  ];
  return _chartDate;
}

class Spo2Data{
  Spo2Data(this.time, this.value);
  final DateTime time;
  final double value;

  factory Spo2Data.fromJson(Map<dynamic,dynamic> parsedJson){
    return Spo2Data(
      parsedJson['time'],
      parsedJson['value'],
    );
  }  }




