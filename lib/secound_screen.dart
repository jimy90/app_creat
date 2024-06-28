
import 'dart:js_util';
import 'package:app_creat/model_sample_file.dart';
import 'package:app_creat/fact_record_list.dart';
import 'package:app_creat/third_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
     
  }

  final colorList = <Color>[
    Color.fromARGB(255, 10, 172, 236),
    Color.fromARGB(245, 224, 209, 8),
    Color.fromARGB(196, 239, 5, 196),
  ];

  @override
  Widget build(BuildContext context) {
    statesServices sstatesServices = statesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              FutureBuilder(
                future: sstatesServices.FactRecordList() ,// Accessing instance method through object
                builder: (context, AsyncSnapshot<Contries> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: PieChart(
                                  dataMap: {
                                    "Total": double.parse(snapshot.data!.cases!.toString()),
                                    "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                                    "Death": double.parse(snapshot.data!.deaths!.toString()),
                                  },
                                  chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                                  chartRadius: MediaQuery.of(context).size.width / 4,
                                  legendOptions: LegendOptions(legendPosition: LegendPosition.bottom),
                                  animationDuration: Duration(milliseconds: 120),
                                  chartType: ChartType.ring,
                                  colorList: colorList,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                      ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                      ReusableRow(title: "Death", value: snapshot.data!.deaths.toString()),
                                      ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                      ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                      ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                      ReusableRow(title: "Today Death", value: snapshot.data!.todayDeaths.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountriesList(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(251, 255, 3, 3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Track Countries', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
        ],
      ),
    );
  }
}
