import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/AstronData.dart';

class SunCard extends StatelessWidget {
  final AstronData astronData;

  SunCard(this.astronData);

@override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: Colors.green[300]),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          new Text('Sun', style: Theme.of(context).textTheme.display1),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.yellow[600],
                          size: 40
                        ),
                        new Icon(FontAwesomeIcons.longArrowAltUp),
                      ]
                    ),
                  ),
                  new Text(
                    astronData.sunrise,
                    style: Theme.of(context).textTheme.title,
                  ),
                ]
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.yellow[800],
                          size: 40,
                        ),
                        new Icon(FontAwesomeIcons.longArrowAltDown),
                      ],
                    ),
                  ),
                  new Text(
                    astronData.sunset,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: new Icon(
                      FontAwesomeIcons.solidMoon,
                      color: Colors.blueGrey[600],
                      size: 40
                    )
                  ),
                  new Text(
                    astronData.dusk,
                    style: Theme.of(context).textTheme.title,
                  ),
                ]
              ),
          ]),
        ],
      ),
    );
  }
}
