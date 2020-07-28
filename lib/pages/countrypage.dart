import 'dart:convert';
import 'package:corona/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List mostAffectedCountry;
  fetchMostAffectedData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      mostAffectedCountry = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchMostAffectedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: Search(mostAffectedCountry));
              },
            )
          ],
          title: Text(
            'দেশ সমূহের বিবরণ',
            style: TextStyle(fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: mostAffectedCountry == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: mostAffectedCountry == null
                    ? 0
                    : mostAffectedCountry.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    height: 30,
                                    child: FittedBox(
                                      child: Text(
                                        mostAffectedCountry[index]['country'],
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: FittedBox(
                                      child: Image.network(
                                        mostAffectedCountry[index]
                                            ['countryInfo']['flag'],
                                        height: 50,
                                        width: 60,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'নিশ্চিত কেস:' +
                                      mostAffectedCountry[index]['cases']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'অসুস্থ:' +
                                      mostAffectedCountry[index]['active']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'সুস্থ:' +
                                      mostAffectedCountry[index]['recovered']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'মৃত্যু:' +
                                      mostAffectedCountry[index]['deaths']
                                          .toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey[100]
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }));
  }
}
