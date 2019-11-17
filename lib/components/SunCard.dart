import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/SunData.dart';

class SunCard extends StatelessWidget {
  SunCard(this.sunData);

  final SunData sunData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Sun', style: Theme.of(context).textTheme.display1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Tooltip(
                    message: 'Sunrise',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidSun,
                            color: Colors.yellow[600],
                            size: 40
                          ),
                          Icon(
                            FontAwesomeIcons.longArrowAltUp,
                            color: Colors.black
                          ),
                        ]
                      ),
                    ),
                  ),
                  Text(
                    sunData.sunrise,
                    style: Theme.of(context).textTheme.title,
                  ),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Tooltip(
                    message: 'Sunset',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidSun,
                            color: Colors.yellow[800],
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.longArrowAltDown,
                            color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    sunData.sunset,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tooltip(
                    message: 'Civil Twilight End (Dusk)',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Icon(
                        FontAwesomeIcons.solidBuilding,
                        color: Colors.blueGrey[600],
                        size: 40
                      )
                    ),
                  ),
                  Text(
                    sunData.civilTwilightEnd,
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
