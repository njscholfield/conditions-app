import 'package:flutter/material.dart';

import 'package:conditions/models/WeatherKit.dart';
import 'package:conditions/components/ClickableLink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentConditions extends StatelessWidget {
  CurrentConditions(this._forecast);
  final WeatherKitData _forecast;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(228, 87, 46, .95),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: <Widget>[
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
                              Icon(FontAwesomeIcons.temperatureHalf,
                                  color: Colors.white, size: 25.0),
                              Text(
                                _forecast.currentWeather.temperature
                                        .round()
                                        .toString() +
                                    'º',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.green[300]),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _forecast.currentWeather.conditionCode,
                          style: Theme.of(context).textTheme.titleLarge,
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
                              child: Icon(FontAwesomeIcons.cloudShowersHeavy,
                                  color: Colors.white, size: 25.0),
                            ),
                            Text(
                                '${(_forecast.forecastDaily.days[0].precipitationChance * 100).round()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.blue[200])),
                          ],
                        ),
                        Text(
                          'Precipitation',
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(color: Colors.white),
              // Text(
              //   (_forecast.minutely != null)
              //       ? _forecast.minutely.summary
              //       : _forecast.hourly.summary,
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ClickableLink(
                  url: _forecast.currentWeather.metadata.attributionUrl,
                  child: Text(
                    'Powered by  Weather',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ])
          ],
        ));
  }
}
