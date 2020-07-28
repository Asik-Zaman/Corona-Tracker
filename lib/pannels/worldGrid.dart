import 'package:flutter/material.dart';

class WorldWideGrid extends StatelessWidget {
  final Map worldData;

  const WorldWideGrid({Key key, this.worldData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          SliverPanel(
            panelColor: Colors.red[100],
            textColor: Colors.red[900],
            title: 'মোট সনাক্ত',
            count: worldData['cases'].toString(),
          ),
          SliverPanel(
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            title: 'চিকিৎসাধীন',
            count: worldData['active'].toString(),
          ),
          SliverPanel(
            panelColor: Colors.green[100],
            textColor: Colors.green[900],
            title: 'সুস্থ',
            count: worldData['recovered'].toString(),
          ),
          SliverPanel(
            panelColor: Colors.grey[400],
            textColor: Colors.white,
            title: 'মৃত্যু',
            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class SliverPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const SliverPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: panelColor,
      ),
      margin: EdgeInsets.all(5),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: textColor),
              ),
              Text(
                count,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
