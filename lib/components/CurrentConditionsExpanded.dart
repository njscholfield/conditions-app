import 'package:flutter/material.dart';

import 'package:conditions/components/ClickableLink.dart';
import 'package:conditions/models/WeatherKit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentConditionsExpanded extends StatelessWidget {
  CurrentConditionsExpanded(this._forecast, this.unitIdx);
  final WeatherKitData _forecast;
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
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    spacing: 50.0,
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 20.0,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Current Temperature',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.temperatureHalf, color: Colors.white, size: 25.0),
                                Text('${_forecast.currentWeather.temperature.round()}º',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.green[300]),
                                ),
                              ],
                            ),
                          ),
                          Text(_forecast.currentWeather.conditionCode,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.cloudShowersHeavy, color: Colors.white, size: 25.0),
                              ),
                              Text('${(_forecast.forecastDaily.days[0].precipitationChance * 100).round()}%',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue[200])
                              ),
                            ],
                          ),
                          Text('Precipitation',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                      Column(
                       children: <Widget>[
                         Tooltip(
                           message: 'Low Temperature',
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Text('${_forecast.forecastDaily.days[0].temperatureMin.round()}º',
                                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.tealAccent[400])
                               ),
                             ],
                           ),
                         ),
                         Text('Low',
                           style: Theme.of(context).textTheme.titleLarge
                         )
                       ],
                     ),
                     Column(
                       children: <Widget>[
                         Tooltip(
                           message: 'High Temperature',
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Text('${_forecast.forecastDaily.days[0].temperatureMax.round()}º',
                                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.tealAccent[400])
                               ),
                             ],
                           ),
                         ),
                         Text('High',
                           style: Theme.of(context).textTheme.titleLarge
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
                                   Icon(FontAwesomeIcons.droplet, color: Colors.white, size: 25.0),
                                   Text('${(_forecast.currentWeather.humidity * 100).round()}%',
                                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.cyan[300])
                                   ),
                                 ],
                               ),
                               Text('Humidity',
                                 style: Theme.of(context).textTheme.titleLarge,
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
                                   Text('${_forecast.currentWeather.windSpeed.round()}',
                                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.cyan[300]),
                                   ),
                                   Text(windLabels[unitIdx],
                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.cyan)
                                   )
                                 ],
                               ),
                               Text('Wind Speed',
                                 style: Theme.of(context).textTheme.titleLarge,
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
                                   Text('${(_forecast.currentWeather.cloudCover * 100).round()}%',
                                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.cyan),
                                   ),
                                 ],
                               ),
                               Text('Cloud Cover',
                                 style: Theme.of(context).textTheme.titleLarge,
                               ),
                             ]
                           )
                         ],
                       ),
                     ),
                     Divider(color: Colors.white),
                    //  Text((_forecast.minutely != null) ? _forecast.minutely.summary : _forecast.hourly.summary,
                    //    style: Theme.of(context).textTheme.titleLarge,
                    //  ),
                     Padding(
                       padding: const EdgeInsets.only(top: 20.0),
                       child: ClickableLink(
                         url: _forecast.currentWeather.metadata.attributionUrl,
                         child: Text('Powered by  Weather',
                           style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                           textAlign: TextAlign.right,
                         ),
                       ),
                     )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}