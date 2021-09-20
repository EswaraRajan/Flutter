import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

var url =
    Uri.parse("https://corona.lmao.ninja/v2/countries/india?yesterday=false");
Future<Covid> fetchData() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Covid.fromJson(json.decode(response.body));
  } else {
    throw Exception("Page Not Load");
  }
}

class Covid {
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;

  Covid(
      {required this.cases,
      required this.deaths,
      required this.recovered,
      required this.active,
      required this.updated});
  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
        cases: json['cases'],
        deaths: json['deaths'],
        recovered: json['recovered'],
        active: json['active'],
        updated: json['updated']);
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Covid>? futurecovid;
  @override
  void initState() {
    futurecovid = fetchData();
    super.initState();
  }

  String _dataValue(int timeInMillis) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat("dd-MM-yyyy hh:mm:ss").format(date);
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Covid>(
        future: futurecovid,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/Corona_.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cases : ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.yellow,
                            ),
                          ),
                          Text(
                            snapshot.data!.cases.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recovered : ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          Text(
                            snapshot.data!.recovered.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active : ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            snapshot.data!.active.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deaths : ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            snapshot.data!.deaths.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                              'Designed by Esan\nLast Update : ${_dataValue(snapshot.data!.updated)}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
