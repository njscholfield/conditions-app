import 'package:flutter/material.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

import 'package:conditions/components/ClickableLink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DarkSkyExpanded extends StatelessWidget {
  DarkSkyExpanded(this._forecast, this.unitIdx);
  final Forecast _forecast;
  final int unitIdx;
  final List<String> windLabels = ['', 'kph', 'mph', 'mph', 'm/s'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(228, 87, 46, .95),
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
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
                        children: <Widget>[
                          Tooltip(
                            message: 'Current Temperature',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.thermometerHalf, color: Colors.white, size: 25.0),
                                Text('${_forecast.currently.temperature.round()}º',
                                  style: Theme.of(context).textTheme.display1.copyWith(color: Colors.green[300]),
                                ),
                              ],
                            ),
                          ),
                          Text(_forecast.currently.summary,
                            style: Theme.of(context).textTheme.title,
                            textAlign: TextAlign.center,
                          )
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.tint, color: Colors.white, size: 25.0),
                              Text('${(_forecast.currently.humidity * 100).round()}%',
                                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.cyan[300])
                              ),
                            ],
                          ),
                          Text('Humidity',
                            style: Theme.of(context).textTheme.title,
                          )
                        ]
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(FontAwesomeIcons.wind, color: Colors.white),
                              ),
                              Text('${_forecast.currently.windSpeed.round()}',
                                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.cyan[300]),
                              ),
                              Text(windLabels[unitIdx],
                                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.cyan)
                              )
                            ],
                          ),
                          Text('Wind Speed',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ]
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(FontAwesomeIcons.cloud, color: Colors.white, size: 25.0)
                              ),
                              Text('${(_forecast.currently.cloudCover * 100).round()}%',
                                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.cyan),
                              ),
                            ],
                          ),
                          Text('Cloud Cover',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ]
                      )
                    ],
                  ),
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
                ),
              ]
            )
          ],
        )
      )
    );
  }
}