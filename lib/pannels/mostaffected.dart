
import 'package:flutter/material.dart';

class MostAffectedCountries extends StatelessWidget {
  final List mostAffectedCountry;

  const MostAffectedCountries({Key key, this.mostAffectedCountry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 40,
                    child: FittedBox(
                      child: Image.network(
                        mostAffectedCountry[index]['countryInfo']['flag'],
                        height: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 120,
                    child: FittedBox(
                      child: Text(
                        mostAffectedCountry[index]['country'],
                        style: TextStyle(
                            color: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 120,
                    child: FittedBox(
                      child: Text(
                        'Deaths: ' +
                            mostAffectedCountry[index]['deaths'].toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
