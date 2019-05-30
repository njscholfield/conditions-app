import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/AstronData.dart';

class MoonCard extends StatelessWidget {
  final AstronData astronData;

  MoonCard(this.astronData);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: Colors.blue[200]),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
      child: Column(
        children: <Widget>[
          new Text('Moon', style: Theme.of(context).textTheme.display1),
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
                          FontAwesomeIcons.solidMoon,
                          color: Colors.blueGrey[600],
                          size: 40
                        ),
                        new Icon(FontAwesomeIcons.longArrowAltUp),
                      ]
                    ),
                  ),
                  new Text(
                    astronData.moonrise,
                    style: Theme.of(context).textTheme.title,
                  ),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: new Row(
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.solidMoon,
                          color: Colors.blueGrey[600],
                          size: 40,
                        ),
                        new Icon(FontAwesomeIcons.longArrowAltDown),
                      ],
                    ),
                  ),
                  new Text(
                    astronData.moonset,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    astronData.percentFull,
                    // style: Theme.of(context).textTheme.display1,
                    style: TextStyle(color: Colors.teal, fontSize: 40)
                  ),
                  new Text(
                    'Full',
                    style: Theme.of(context).textTheme.title
                  )
                ],
              ),
            ]
          ),
          new Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: new Text('Closest Phase', style: Theme.of(context).textTheme.headline),
          ),
          new Text('${astronData.closestPhase}: ${astronData.closestPhaseDate}'),
        ],
      ),
    );
  }
}