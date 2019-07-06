import 'package:flutter/material.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

import 'package:conditions/components/ClickableLink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DarkSky extends StatelessWidget {
  DarkSky(this._forecast);
  final Future<Forecast> _forecast;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(228, 87, 46, .95),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FutureBuilder<Forecast>(
            future: _forecast,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(FontAwesomeIcons.thermometerHalf, color: Colors.white, size: 25.0),
                                  new Text(snapshot.data.currently.temperature.round().toString() + 'º',
                                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.green[300]),
                                  ),
                                ],
                              ),
                              new Text(snapshot.data.currently.summary,
                                style: Theme.of(context).textTheme.title,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: new Column(
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Icon(FontAwesomeIcons.cloudShowersHeavy, color: Colors.white, size: 25.0),
                                  ),
                                  new Text('${(snapshot.data.currently.precipProbability * 100).round()}%',
                                    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.blue[200])
                                  ),
                                ],
                              ),
                              new Text('Precipitation',
                                style: Theme.of(context).textTheme.title,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    new Divider(color: Colors.white),
                    new Text('Next Hour: ${snapshot.data.minutely.summary}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new ClickableLink(
                        url: 'https://darksky.net/poweredby/',
                        child: new Text('Powered by Dark Sky',
                          style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  ]
                );
              } else if(snapshot.hasError) {
                return Center(
                  child: new Text('Error loading weather data')
                );
              } else {
                return Center(
                  child: new Text('Waiting for weather data...')
                );
              }
            }
          ),
        ],
      )
    );
  }

}