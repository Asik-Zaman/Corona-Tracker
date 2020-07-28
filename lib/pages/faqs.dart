import 'package:corona/source.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('প্রশ্ন এবং উত্তর',style: TextStyle(fontSize: 23)),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: DataSource.questionAnswer.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(
                  DataSource.questionAnswer[index]['question'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(DataSource.questionAnswer[index]['answer']),
                  )
                ],
              );
            }));
  }
}
