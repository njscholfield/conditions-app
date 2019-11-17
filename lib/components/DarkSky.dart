import 'package:flutter/material.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

import 'package:conditions/components/ClickableLink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DarkSky extends StatelessWidget {
  DarkSky(this._forecast);
  final Forecast _forecast;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(228, 87, 46, .95),
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Tooltip(
                          message: 'Current Temperature',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.thermometerHalf, color: Colors.white, size: 25.0),
                              Text(_forecast.currently.temperature.round().toString() + 'º',
                                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.green[300]),
                              ),
                            ],
                          ),
                        ),
                        Text(_forecast.currently.summary,
                          style: Theme.of(context).textTheme.title,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(FontAwesomeIcons.cloudShowersHeavy, color: Colors.white, size: 25.0),
                            ),
                            Text('${(_forecast.currently.precipProbability * 100).round()}%',
                              style: Theme.of(context).textTheme.display1.copyWith(color: Colors.blue[200])
                            ),
                          ],
                        ),
                        Text('Precipitation',
                          style: Theme.of(context).textTheme.title,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(color: Colors.white),
              Text((_forecast.minutely != null) ? _forecast.minutely.summary : _forecast.hourly.summary,
                style: Theme.of(context).textTheme.title,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ClickableLink(
                  url: 'https://darksky.net/poweredby/',
                  child: Text('Powered by Dark Sky',
                    style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ]
          )
        ],
      )
    );
  }
}