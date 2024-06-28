import 'package:app_creat/fact_record_list.dart';
import 'package:app_creat/four_sereen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    statesServices sstatesServices = statesServices();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countries",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 54, 126, 250),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: sstatesServices.ContriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                    width: 100, height: 10, color: Colors.grey),
                                subtitle: Container(
                                    width: 50, height: 10, color: Colors.grey),
                                leading: Container(
                                    width: 50, height: 50, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]["country"];

                        if (searchController.text.isEmpty ||
                            name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen( image: snapshot.data![index] ['countryInfo']['flag'],
                                              name: snapshot.data![index] ['country'],
                                              totalCases: snapshot.data![index] ['cases'],
                                              totalRecovered: snapshot.data![index]['recoverd'],
                                              totalDeaths: snapshot.data![index] ['deaths'],
                                              active: snapshot.data![index] ['active'],
                                              test: snapshot.data![index] ['test'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index] ['critical'],
                                            )),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Center(child: Text("Error loading data"));
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
