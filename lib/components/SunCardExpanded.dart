import 'package:conditions/components/ClickableLink.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/SunData.dart';

class SunCardExpanded extends StatelessWidget {
  SunCardExpanded(this.sunData);

  final SunData sunData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.green[300],
        borderRadius: const BorderRadius.all( Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Wrap(
                    spacing: 40.0,
                    alignment: WrapAlignment.spaceAround,
                    runSpacing: 20.0,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Astronomical Twilight Begin',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Icon(
                                FontAwesomeIcons.userAstronaut,
                                size: 40,
                                color: Colors.blueGrey[100]
                              ),
                            ),
                          ),
                          Text(
                            sunData.astroTwilightBegin,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Nautical Twilight Begin',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12, right: 10.0),
                              child: Icon(
                                FontAwesomeIcons.ship,
                                size: 40,
                                color: Colors.blueGrey[300],
                              ),
                            )
                          ),
                          Text(
                            sunData.nauticalTwilightBegin,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ]
                      ),
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Civil Twilight Begin (Dawn)',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Icon(
                                FontAwesomeIcons.solidBuilding,
                                size: 40,
                                color: Colors.blueGrey[400]
                              )
                            ),
                          ),
                          Text(
                            sunData.civilTwilightBegin,
                            style: Theme.of(context).textTheme.titleLarge
                          )
                        ]
                      ),
                       Column(
                        children: <Widget>[
                           Tooltip(
                            message: 'Sunrise',
                             child: Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 65.0),
                                 child: Row(
                                  children: <Widget>[
                                     Icon(
                                      FontAwesomeIcons.solidSun,
                                      color: Colors.yellow[300],
                                      size: 40
                                    ),
                                     Icon(
                                      FontAwesomeIcons.upLong,
                                      color: Colors.black
                                    ),
                                  ]
                                ),
                              ),
                            ),
                          ),
                           Text(
                            sunData.sunrise,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ]
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Tooltip(
                            message: 'Solar Noon',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Icon(
                                FontAwesomeIcons.solidClock,
                                size: 40,
                                color: Colors.yellow
                              ),
                            ),
                          ),
                          Text(
                            sunData.solarNoon,
                            style: Theme.of(context).textTheme.titleLarge
                          )
                        ]
                      ),
                       Column(
                        children: <Widget>[
                           Tooltip(
                            message: 'Sunset',
                             child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 65.0),
                                 child: Row(
                                  children: <Widget>[
                                     Icon(
                                      FontAwesomeIcons.solidSun,
                                      color: Colors.yellow[800],
                                      size: 40,
                                    ),
                                     Icon(
                                      FontAwesomeIcons.downLong,
                                      color: Colors.black
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                           Text(
                            sunData.sunset,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                       Column(
                        children: <Widget>[
                           Tooltip(
                            message: 'Civil Twilight End (Dusk)',
                             child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                               child: Icon(
                                FontAwesomeIcons.solidBuilding,
                                color: Colors.blueGrey[600],
                                size: 40
                              )
                            ),
                          ),
                           Text(
                            sunData.civilTwilightEnd,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ]
                      ),
                       Column(
                        children: <Widget>[
                           Tooltip(
                            message: 'Nautilcal Twilight End',
                             child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0, right: 10.0),
                               child: Icon(
                                FontAwesomeIcons.ship,
                                size: 40,
                                color: Colors.blueGrey[700]
                              ),
                            ),
                          ),
                           Text(
                            sunData.nauticalTwilightEnd,
                            style: Theme.of(context).textTheme.titleLarge
                          )
                        ]
                      ),
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Astronomical Twilight End',
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Icon(
                                FontAwesomeIcons.userAstronaut,
                                size: 40,
                                color: Colors.blueGrey[900]
                              ),
                            )
                          ),
                          Text(
                            sunData.astroTwilightEnd,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Tooltip(
                            message: 'Day Length',
                             child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                               child: Icon(
                                FontAwesomeIcons.stopwatch,
                                color: Colors.indigoAccent,
                                size: 40
                              ),
                            ),
                          ),
                          Text(
                            sunData.dayLength,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('All times are in your current time zone',
                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)
                  ),
                ),
                  ClickableLink(
                  url: 'https://www.timeanddate.com/astronomy/different-types-twilight.html',
                  child: Text(
                    'Twilight, Dawn, and Dusk Info',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
