import 'package:covid_tracker/View/WorldStats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget
{
  final String title;
  final String totalCases;
  final String todayCases;
  final String recovered;
  final String death;
  final String critical;
  final String todayRecovered;
  final String images;


  DetailScreen({
    Key? key,
    required this.title,
    required this.totalCases,
    required this.todayCases,
    required this.recovered,
    required this.death,
    required this.critical,
    required this.todayRecovered,
    required this.images

  }): super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.069,),
                              ReusableRow(title: "Total Cases", value: widget.totalCases),
                              ReusableRow(title: "Today Case", value: widget.todayCases),
                              ReusableRow(title: "Recovered", value: widget.recovered),
                              ReusableRow(title: "Death", value: widget.death),
                              ReusableRow(title: "Critical", value: widget.critical),
                              ReusableRow(title: "Today Recovered", value: widget.todayRecovered),
                            ],
                          ),
                        ),
                      ),
                   CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.images),
                      ),
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}
