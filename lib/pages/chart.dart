import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'dart:convert';



// class ChartMqtt extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//     return ChartSfCartesian();
//     //_sfCartesianChart();
//     //Text('xxx')
//   }
// }


//Chart
class ChartSfCartesian extends StatefulWidget {

  final  double temp;
  final String nameChart;

  const ChartSfCartesian({
    Key? key, 
    required this.nameChart, 
    required this.temp, 
    // required this.temp, 
  }) : super(key: key);

  @override
  State<ChartSfCartesian> createState() => _ChartSfCartesianState();

}

class _ChartSfCartesianState extends State<ChartSfCartesian> with AutomaticKeepAliveClientMixin {
  
  //  late Timer temp;
  late List<LiveData> chartData;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  double function = 10;
  int count=0;

  @override
  void initState() {

    chartData = getChartData();
    print(chartData);
    // updateDataSource(widget.temp);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, maximumZoomLevel:0.8); //hacer zoom con doble toque
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic( Duration(seconds: 10), updateDataSource);
    print('pasa Timer');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final double temp;
    super.build(context);
    return Column(
      children: [SfCartesianChart(
      zoomPanBehavior: _zoomPanBehavior,
      title: ChartTitle(text: widget.nameChart),
      plotAreaBorderWidth: 2, //lineas del fondo del gráfico
      legend: Legend(isVisible: false),
      tooltipBehavior: _tooltipBehavior, //*muestra los datos de cada punto
      
      //<LiveData, DateTime>
      series: <ChartSeries>[
      LineSeries<LiveData, DateTime>(
      onRendererCreated: (ChartSeriesController conttroller){
        _chartSeriesController = conttroller;
      // setState(() {
      //   updateDataSource(widget.temp);
      // });
      },
      dataSource: chartData,
      // name: 'Temperatura',
      xValueMapper: (LiveData sales, _) => sales.time,
      yValueMapper: (LiveData sales, _) => sales.sales 
      )],
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
        numberFormat: NumberFormat.simpleCurrency(name:'°C ',decimalDigits: 1),
        // title: AxisTitle(text: 'Temperatura'),
    
        ),
      ),
      // FloatingActionButton(
      //   onPressed: (){
      //     setState(() {
      //     count++;
      //     updateDataSource(count);
            
      //     });
      //   }
      // )
      ]
      
    );
    
  }

    int time = 19;
  void updateDataSource(Timer temp) {
    print('updatexxxx');
    final dateTime = DateTime.now();
    function = (math.Random().nextInt(60) + 30);
    // setState(() {
    //   function;
    // });
    chartData.add(LiveData(dateTime, widget.temp));
    print('xxxxxxxxxxx');
    print(dateTime);
    print(widget.temp);
    print('xxxxxxxxxxx');
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
  
  @override
  bool get wantKeepAlive => true;
  

}


List<LiveData> getChartData(){
  final List<LiveData> _chartDate = [
    LiveData(DateTime.now(), 10),
    LiveData(DateTime.now(), 50),
    // LiveData(DateTime(2021, 6, 6), 0),
    // LiveData(DateTime(2021, 6, 7), 65),
    // LiveData(DateTime(2021, 6, 6), 0),
    // LiveData(DateTime(2021, 6, 7), 100),
  ];
  return _chartDate;
}


class LiveData{
  LiveData(this.time, this.sales);
 final DateTime time;
 final double sales;
}


