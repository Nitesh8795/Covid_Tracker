import 'dart:convert';
import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class worldStatesServices
{
  Future<WorldStatesModel> getWorldStatesRecord() async
  {
    final Response = await http.get(Uri.parse(App_URl.worldStates));

    if(Response.statusCode == 200)
      {
        var data = jsonDecode(Response.body);

        return WorldStatesModel.fromJson(data);
      }
    else
      {
        throw Exception("No Data Found");
      }
  }

  Future<List<dynamic>> getCountriesData() async
  {
    var data;

    final Response = await http.get(Uri.parse(App_URl.countriesList));

    if(Response.statusCode == 200)
    {
      data = jsonDecode(Response.body);

      return data;
    }
    else
    {
      throw Exception("No Data Found");
    }
  }

}