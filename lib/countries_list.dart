import 'package:covid/service/detail.dart';
import 'package:covid/service/state.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  TextEditingController sreach = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SateService service = SateService();
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
              controller: sreach,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Sreach With Country Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: service.fetchcontries(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (sreach.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Detail(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalcase:
                                                        snapshot.data![index]
                                                            ['todayCases'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    critcal:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalrecoverd:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    todayrecoverd:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todaydeath:
                                                        snapshot.data![index]
                                                            ['todayDeaths'],
                                                  )));
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Detail(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalcase:
                                                        snapshot.data![index]
                                                            ['todayCases'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    critcal:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalrecoverd:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    todayrecoverd:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todaydeath:
                                                        snapshot.data![index]
                                                            ['todayDeaths'],
                                                  )),
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else if (name
                                .toLowerCase()
                                .contains(sreach.text.toLowerCase())) {
                              return Column(
                                children: [
                                  ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  )
                                ],
                              );
                            } else {
                              Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
