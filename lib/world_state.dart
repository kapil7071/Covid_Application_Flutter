import 'package:covid/countries_list.dart';
import 'package:covid/model/wroldstate.dart';
import 'package:covid/service/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldSate extends StatefulWidget {
  const WorldSate({super.key});

  @override
  State<WorldSate> createState() => _WorldSateState();
}

class _WorldSateState extends State<WorldSate> with TickerProviderStateMixin {
  late final AnimationController control =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    control.dispose();
  }

  final ColorList = <Color>[
    const Color.fromARGB(255, 0, 98, 255),
    const Color.fromARGB(255, 7, 204, 10),
    const Color.fromARGB(255, 255, 0, 0),
  ];
  @override
  Widget build(BuildContext context) {
    SateService sateservice = SateService();
    return Scaffold(
      //backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              FutureBuilder(
                  future: sateservice.fetchworldstaterocrd(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: control,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death":
                                  double.parse(snapshot.data!.deaths.toString())
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: ColorList,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Reused(
                                      title: "Total",
                                      value:
                                          (snapshot.data!.cases!.toString())),
                                  Reused(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  Reused(
                                      title: "Death",
                                      value: snapshot.data!.deaths.toString()),
                                  Reused(
                                      title: "Active",
                                      value: snapshot.data!.active.toString()),
                                  Reused(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  Reused(
                                      title: "Today Death",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  Reused(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Countries()));
                            },
                            child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green),
                                child: const Center(
                                    child: Text(
                                  "Track Countirs",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class Reused extends StatelessWidget {
  String title, value;
  Reused({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
