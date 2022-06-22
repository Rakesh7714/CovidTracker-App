import 'package:covid_tracker/Models/world_States_Model.dart';
import 'package:covid_tracker/View/countries_lists.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
  //StatesService statesService = StatesService();
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build( BuildContext context){
    StatesService statesService = StatesService();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height* .01,),
              FutureBuilder(
                future: statesService.fetchworldStateRecord(),
                  builder:(context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return  Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            controller: _controller,
                            size: 50.0,
                          ),
                      );
                    } else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap:  {
                              "Total" :double.parse(snapshot.data!.cases.toString(),),
                              "Recovered":double.parse(snapshot.data!.recovered.toString(),),
                              "Death": double.parse(snapshot.data!.deaths.toString(),)
                             // "Deaths" :5 ,
                            },
                            chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width / 2.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                          ),
                          Padding(padding:EdgeInsets.symmetric(vertical :MediaQuery.of(context).size.height *.03)),
                          Card(
                            child: Column(
                              children: [
                                ReusableRow(title:'Total Case', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title:'Total Death', value: snapshot.data!.deaths.toString()),
                                ReusableRow(title:'Active', value: snapshot.data!.active.toString()),
                                ReusableRow(title:'Critical', value: snapshot.data!.critical.toString()),
                                ReusableRow(title:'Today death', value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title:'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                          Padding(padding:EdgeInsets.symmetric(vertical :MediaQuery.of(context).size.height *.02)),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesLists()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 50,
                              child: const Center(child: Text('Track Countries')),

                            ),
                          ),
                        ],

                      );
                    }
                  }


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
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10 ,right: 10,top: 10,bottom:5 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

