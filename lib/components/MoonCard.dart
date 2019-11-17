import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/MoonData.dart';

class MoonCard extends StatelessWidget {
  MoonCard(this.moonData);

  final MoonData moonData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Moon', style: Theme.of(context).textTheme.display1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Tooltip(
                      message: 'Moonrise',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.blueGrey[600],
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
                      moonData.moonrise,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ]
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Tooltip(
                      message: 'Moonset',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.blueGrey[600],
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
                      moonData.moonset,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        moonData.moonPhase,
                        style: TextStyle(color: Colors.teal, fontSize: 30)
                      ),
                    ),
                    Text(
                      'Full',
                      style: Theme.of(context).textTheme.title
                    )
                  ],
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Current Phase', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black)),
          ),
          Text(moonData.moonPhaseDesc, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}