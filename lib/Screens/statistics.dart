import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Statistisc.dart';
import 'package:untitled5/Studentsdao.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Statistics extends StatefulWidget {

  late int computer;
  late int machine;
  late int electricity;
  late int material;

  Statistics({required this.computer, required this.machine, required this.electricity, required this.material});

  late final String title;

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  Future<void> studentsShow() async {
    _chartData = getChartData(widget.computer, widget.machine, widget.electricity, widget.material);
  }

  @override

  void initState() {
    //_chartData = getChartData(5);
    studentsShow();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SfCircularChart(
        title: ChartTitle(text: 'Teknoloji Fakültesi Bölümleri Öğrenci Sayıları İstatistlik Sonuçları \n (∝) \n'),
        legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data,_) => data.continent,
              yValueMapper: (GDPData data,_) => data.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true
          )
        ],
      ),
    )
    );
  }

  List<GDPData> getChartData(int computer, int machine, int electricity, int material){
    final List<GDPData> chartData = [
      GDPData("Teknoloji Fakültesi Bilgisayar Mühendisliği",computer),
      GDPData("Teknoloji Fakültesi Makine Mühendisliği", machine),
      GDPData("Elektrik Elektronik Mühendisliği", electricity),
      GDPData("Metalurji ve Malzeme Mühendisliği", material),
    ];
    return chartData;
  }

}

class GDPData{
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
