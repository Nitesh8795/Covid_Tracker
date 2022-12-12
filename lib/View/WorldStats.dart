import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({Key? key}) : super(key: key);

  @override
  State<WorldStatus> createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> with TickerProviderStateMixin
{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = const <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              PieChart(
                  dataMap: const{
                    "Total" : 300,
                    "Recovered" : 200,
                    "Death" : 100
                  },
                chartType: ChartType.ring,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                ),
                animationDuration: const Duration(milliseconds: 2000),
                colorList: colorList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
