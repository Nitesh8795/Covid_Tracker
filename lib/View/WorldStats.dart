import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/View/countries_list.dart';

class WorldStatus extends StatefulWidget {
  const WorldStatus({Key? key}) : super(key: key);

  @override
  State<WorldStatus> createState() => _WorldStatusState();
}

class _WorldStatusState extends State<WorldStatus> with TickerProviderStateMixin
{
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

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
    worldStatesServices statesServices = worldStatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder<WorldStatesModel>(
                future: statesServices.getWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot)
                {
                  if(!snapshot.hasData)
                  {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 70,
                      ),
                    );
                  }
                  else
                  {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Death": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                          ),
                          chartLegendSpacing: 32,
                          chartType: ChartType.ring,
                          initialAngleInDegree: 0,
                          ringStrokeWidth: 20,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            showLegendsInRow: false,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          animationDuration: const Duration(milliseconds: 2000),
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap : (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text(
                              "Track Countries",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 7,
          ),
          Divider(),
        ],
      ),
    );
  }
}
