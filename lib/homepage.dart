import 'dart:convert';
import 'package:corona/pages/bangladesh.dart';
import 'package:corona/pages/countrypage.dart';
import 'package:corona/pannels/infopanel.dart';
import 'package:corona/pannels/mostaffected.dart';
import 'package:corona/pannels/worldGrid.dart';
import 'package:corona/source.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List mostAffectedCountry;
  fetchMostAffectedData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      mostAffectedCountry = json.decode(response.body);
    });
  }

  Map bdData;
  fetchBdData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries/bangladesh');
    setState(() {
      bdData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchMostAffectedData();
    fetchBdData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'কোভিড-১৯',
          style: TextStyle(
              color: Colors.blue, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.orange[100],
                ),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                  DataSource.qoute,
                  style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'বিশ্বব্যাপী',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BangladeshPage(
                                        bdData: bdData,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryBlack,
                          ),
                          child: Text(
                            'বাংলাদেশ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryBlack,
                          ),
                          child: Text(
                            'দেশভিত্তিক',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )),
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldWideGrid(
                      worldData: worldData,
                    ),
              SizedBox(
                height: 10,
              ),
              worldData == null
                  ? CircularProgressIndicator()
                  : PieChart(
                      dataMap: {
                        'নিশ্চিত কেস:': worldData['cases'].toDouble(),
                        'অসুস্থ:': worldData['active'].toDouble(),
                        'সুস্থ:': worldData['recovered'].toDouble(),
                        'মৃত্যু:': worldData['deaths'].toDouble(),
                      },
                      colorList: [
                        Colors.red[200],
                        Colors.blue[400],
                        Colors.green[200],
                        Colors.grey[500],
                      ],
                    ),
              SizedBox(
                height: 10,
              ),
              Text(
                'সর্বাধিক আক্রান্ত দেশ',
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              mostAffectedCountry == null
                  ? Container()
                  : MostAffectedCountries(
                      mostAffectedCountry: mostAffectedCountry,
                    ),
              SizedBox(
                height: 10,
              ),
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'Crafted with "LOVE" by Asik  ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              )),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
