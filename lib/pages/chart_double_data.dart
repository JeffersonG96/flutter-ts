
import 'dart:async';

import 'package:flutter/material.dart';
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
  late List<LiveData> chartData;
  late List<ChartData> chartData2;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  double function = 10;
  int count=0;

  @override
  void initState() {

    chartData = getChartData();
    chartData2 = getChartData2();
    print(chartData);
    // updateDataSource(widget.temp);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, maximumZoomLevel:0.8); //hacer zoom con doble toque
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic( Duration(seconds: 10), updateDataSource);
    Timer.periodic( Duration(seconds: 9), updateDataSource2);
    print('pasa Timer');
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
      LineSeries<LiveData, DateTime>(
      onRendererCreated: (ChartSeriesController conttroller){
        _chartSeriesController = conttroller;
      },
      color: Colors.green,
      dataSource: chartData,
      name: 'BPM',
      xValueMapper: (LiveData sales, _) => sales.time,
      yValueMapper: (LiveData sales, _) => sales.bpm 
      ),

      LineSeries<ChartData, DateTime>(
      onRendererCreated: (ChartSeriesController conttroller){
        _chartSeriesController = conttroller;
      },
      dataSource: chartData2,
      name: 'SPo2 %',
      xValueMapper: (ChartData sales, _) => sales.time,
      yValueMapper: (ChartData sales, _) => sales.spo2 
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
        numberFormat: NumberFormat.simpleCurrency(name:'s',decimalDigits: 1),
        maximum: 101,
        // title: AxisTitle(text: 'Temperatura'),
        
        ),
      ),
    );
    
  }


  void updateDataSource(Timer temp) {
    final dateTime = DateTime.now();
    chartData.add(LiveData(dateTime, widget.heart));
    print('Longitud de LISTA: ${chartData.length}');
    if(chartData.length == 100){
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
    addedDataIndex: chartData.length - 1, 
    removedDataIndex: 0,
    ); 
    } else {
      _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length -1,
      );
    }
  }

  void updateDataSource2(Timer temp) {
    final dateTime = DateTime.now();
    chartData2.add(ChartData(dateTime, widget.spo2));
    print('Longitud de LISTA: ${chartData.length}');
    if(chartData2.length == 100){
    chartData2.removeAt(0);
    _chartSeriesController.updateDataSource(
    addedDataIndex: chartData2.length - 1, 
    removedDataIndex: 0,
    ); 
    } else {
      _chartSeriesController.updateDataSource(
        addedDataIndex: chartData2.length -1,
      );
    }
  }


  
  @override
  bool get wantKeepAlive => true;
  

}


List<LiveData> getChartData(){
  final List<LiveData> _chartDate = [

  ];
  return _chartDate;
}

List<ChartData> getChartData2(){
  final List<ChartData> _chartDate2 = [

  ];
  return _chartDate2;
}


class LiveData{
  LiveData(this.time, this.bpm);
 final DateTime time;
 final double bpm;
}

class ChartData{
  ChartData(this.time, this.spo2);
 final DateTime time;
 final double spo2;
}


