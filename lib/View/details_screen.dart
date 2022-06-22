import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases ,totalDeaths ,totalRecovered ,active , critical , todayRecovered,test;


   DetailsScreen({Key? key,
     required this.name,
     required this.image,
     required this.active,
     required this.critical,
     required this.test,
     required this.todayRecovered,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height *.087),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(title: 'cases', value: widget.totalCases.toString()),
                      //ReusableRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                      ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Active', value: widget.active.toString()),
                      ReusableRow(title: 'Test', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
