import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
{
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    worldStatesServices statesServices = worldStatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0, bottom: 10.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with name of country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.getCountriesData(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot)
                {
                  if(!snapshot.hasData)
                    {
                      return ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index)
                        {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10, width: 20, color: Colors.white,),
                                    subtitle: Container(height: 10, width: 20, color: Colors.white,),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    )
                                  )
                                ],
                              ),
                          );
                        },
                      );
                    }
                  else
                    {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index)
                        {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 60,
                                  width: 60,
                                  image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag']
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
