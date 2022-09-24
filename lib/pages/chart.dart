import 'dart:async';
import 'dart:convert';

import 'package:app_login/providers/bar_provider.dart';
import 'package:app_login/services/data_chart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';


//Chart
class ChartSfCartesian extends StatefulWidget {

  
  // final  double temp;
  // final String nameChart;

  // const ChartSfCartesian({
  //   Key? key, 
  //   required this.nameChart, 
  //   required this.temp, 
  //   // required this.temp, 
  // }) : super(key: key);

  @override
  State<ChartSfCartesian> createState() => _ChartSfCartesianState();

}

class _ChartSfCartesianState extends State<ChartSfCartesian> with AutomaticKeepAliveClientMixin {
  
  List<TemperaturaData> tempData = [];
  late DataChartService dataChartService;
  late BarProvider barProvider;


  //  late Timer temp;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  double function = 10;
  int counter = 0;
  // DateTime x = DateTime.now();

  @override
  void initState() {
    super.initState();

    Timer.periodic( const Duration(seconds: 10), caragarData);
    tempData=getChartData();
    dataChartService = Provider.of<DataChartService>(context, listen: false);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, maximumZoomLevel:0.8); //hacer zoom con doble toque
    _tooltipBehavior = TooltipBehavior(enable: true);
    caragarData(1);

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
      title: ChartTitle(text: 'Temperatura', textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
      plotAreaBorderWidth: 2, //lineas del fondo del gráfico
      legend: Legend(isVisible: false),
      tooltipBehavior: _tooltipBehavior, //*muestra los datos de cada punto
      
      //<LiveData, DateTime>
      series: <ChartSeries>[
      LineSeries<TemperaturaData, DateTime>(
      dataSource: tempData,
      name: 'Temperatura',
      xValueMapper: (TemperaturaData sales, _) => sales.time,
      yValueMapper: (TemperaturaData sales, _) => sales.value 
      ),
      
      ],
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: DateTimeIntervalType.minutes,
        // rangePadding: ChartRangePadding.round,
        // minimum: DateTime.now(),
        // maximum: DateTime.now(),
        // interval: 20,
        // title: AxisTitle(text: 'Segundos'),
        ),
      primaryYAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.outside,
        tickPosition: TickPosition.inside,
        isVisible: true, //ocultar línea y elementos del eje
        numberFormat: NumberFormat.simpleCurrency(name:'°C ',decimalDigits: 1),
        maximum: 101,
        // title: AxisTitle(text: 'Temperatura'),
        
        ),
      ),
    );
    
  }

  
  @override
  bool get wantKeepAlive => true;


 void caragarData(nul) async {
 
 
  final jsonInt = await dataChartService.getDataChart();

  if(jsonInt != null){
  final dynamic jsonResponse = json.decode(jsonInt);
    tempData = []; //elimina toda la lista
    for (Map<dynamic,dynamic> i in jsonResponse['temp']){
      print(i);
      if(i['variable'] =='temp'){
      final Map<dynamic,dynamic> updateMap = i;
      final DateTime date1 = DateTime.fromMillisecondsSinceEpoch( updateMap['time']);
      updateMap['time'] = date1;
      tempData.add(TemperaturaData.fromJson(updateMap));
      }//if

      }
    counter++;
    if(mounted){
     setState(() {
       counter;
     }); }
}
    // tempData.removeRange(0, lengthData);
}
}

List<TemperaturaData> getChartData(){
  final List<TemperaturaData> _chartDate = [
  ];
  return _chartDate;
}


class TemperaturaData{
  TemperaturaData(this.time, this.value);
  final DateTime time;
  final int value;

  factory TemperaturaData.fromJson(Map<dynamic,dynamic> parsedJson){
    return TemperaturaData(
      parsedJson['time'],
      parsedJson['value'],
    );
  }  }


