import 'package:covid_tracker/View/details_screen.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesLists extends StatefulWidget {
  const CountriesLists({Key? key}) : super(key: key);

  @override
  State<CountriesLists> createState() => _CountriesListsState();
}

class _CountriesListsState extends State<CountriesLists> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
 StatesService  statesService = StatesService();

    return Scaffold(
      appBar: AppBar(
    elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
              controller: searchController,
             onChanged: (value){
               setState(() {
               });
             },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Search Countries name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),

          ),
        ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesService.fetchCountriesRecord(),
                    builder: (context, AsyncSnapshot<List<dynamic>>snapshot ){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.grey.shade100,
                             child: Column(
                               children: [
                                ListTile(
                                 title:Container(height: 10,width: 89,color: Colors.lightBlue,),
                                 subtitle:Container(height: 10,width: 49,color: Colors.lightBlue,),
                                 leading:Container(height: 50,width: 50,color: Colors.lightBlue,),
                              ),


                             ],
                              ) ,
                              );

                          }
                      ); 
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          test: snapshot.data![index]['tests'],
                                          critical: snapshot.data![index]['critical'],
                                          active: snapshot.data![index]['active'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],

                                        )));
                                  },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text('Total Cases: '+snapshot.data![index]['cases'].toString()),
                                    leading:Image(height: 50 , width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),

                                  ),
                                )

                              ],
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          test: snapshot.data![index]['tests'],
                                          critical: snapshot.data![index]['critical'],
                                          active: snapshot.data![index]['active'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],

                                        )));
                                  },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text('Total Cases: '+snapshot.data![index]['cases'].toString()),
                                    leading:Image(height: 50 , width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),

                                  ),
                                )

                              ],
                            );

                          }else{
                            return Container();
                          }
                            return Column(
                              children: [
                                ListTile(
                                  title:Text(snapshot.data![index]['country']),
                                  subtitle:Text('Total Cases: '+snapshot.data![index]['cases'].toString()),
                                  leading:Image(height: 50 , width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),

                                )

                              ],
                            );
                          }
                      );
                    }

                }
                ))
          ],
        ),
      ),
    );
  }
}
