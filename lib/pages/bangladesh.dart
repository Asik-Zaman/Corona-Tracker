import 'package:flutter/material.dart';

class BangladeshPage extends StatelessWidget {
  final Map bdData;

  const BangladeshPage({Key key, this.bdData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'বাংলাদেশ',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              height: 200,
              width: 550,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      bdData['countryInfo']['flag'],
                    ),
                    fit: BoxFit.cover),
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            Text(
              'আজকে আক্রান্ত: ' + bdData['todayCases'].toString(),
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Text(
              'আজকে মৃত্যু: ' + bdData['todayDeaths'].toString(),
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Text(
              'মোট সনাক্ত: ' + bdData['cases'].toString(),
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text(
              'চিকিৎসাধীন: ' + bdData['active'].toString(),
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 37),
            ),
            Text(
              'মোট সুস্থ: ' + bdData['recovered'].toString(),
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Text(
              'মোট মৃত্যু: ' + bdData['deaths'].toString(),
              style: TextStyle(
                  color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            
          ],
        ),
      )),
    );
  }
}
