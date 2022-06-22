import 'dart:convert';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart'as http;
import 'package:covid_tracker/Models/world_states_Model.dart';
class StatesService{
  Future<WorldStatesModel>fetchworldStateRecord()async{
 final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
 if(response.statusCode == 200){
   var data =  jsonDecode(response.body);
   return WorldStatesModel.fromJson(data);
 }else{
   throw Exception('Error');

 }
// var data = jsonDecode(response.body.toString());

  }

  Future<List<dynamic>>fetchCountriesRecord()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    print(response.statusCode.toString());
    print(data);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');

    }

  }
}