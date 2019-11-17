import 'package:conditions/components/SunCardExpanded.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

import 'package:conditions/components/DarkSky.dart';
import 'package:conditions/components/DarkSkyExpanded.dart';
import 'package:conditions/components/SunCard.dart';
import 'package:conditions/components/MoonCard.dart';
import 'package:conditions/components/LocationField.dart';
import 'package:conditions/components/About.dart';
import 'package:conditions/components/Settings.dart';

import 'package:conditions/models/SunData.dart';
import 'package:conditions/models/MoonData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conditions',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[800],
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
          display1: TextStyle(
            color: Colors.white,
          ),
          headline: TextStyle(
            color: Colors.black,
          ),
          body1: TextStyle(
            fontSize: 16.0
          ),
          body2: TextStyle(
            fontSize: 16.0,
            decoration: TextDecoration.underline
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body2: TextStyle(
            fontSize: 16.0,
            decoration: TextDecoration.underline
          )
        )
      ),
      home: MyHomePage(title: 'Conditions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SunData> _sunData;
  Future<MoonData> _moonData;
  Future<Forecast> _darkSky;
  int _unitIdx;

  void updateSunData(Future<SunData> newSunData) {
    setState(() {
      _sunData = newSunData;
    });
  }

  void updateMoonData(Future<MoonData> newMoonData) {
    setState(() {
      _moonData = newMoonData;
    });
  }

  void updateDarkSkyData(Future<Forecast> newDarkSky) {
    setState(() {
      _darkSky = newDarkSky;
    });
  }

  void updateUnitIdx(int newUnitIdx) {
    setState(() {
      _unitIdx = newUnitIdx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ));
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          LocationField(updateSunData, updateMoonData, updateDarkSkyData, updateUnitIdx),
          FutureBuilder<Forecast>(
            future: _darkSky,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if(snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Text(
                        'Updated: ${DateFormat.MMMMEEEEd().add_jm().format(new DateTime.now())}',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DarkSkyExpanded(snapshot.data, _unitIdx);
                          },
                        ));
                      },
                      child: DarkSky(snapshot.data),
                    ),
                  ],
                );
              } else if(snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.exclamationCircle, color: Colors.red),
                      Text('Error loading Dark Sky data', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.red))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }
          ),
          FutureBuilder<SunData>(
            future: _sunData,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Container(child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Sun Details'),
                          ),
                          body: SunCardExpanded(snapshot.data)
                        );
                      },
                    ));
                  },
                  child: SunCard(snapshot.data),
                );
              } else if(snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.exclamationCircle, color: Colors.red),
                      Text('Error loading sun data',
                        style: Theme.of(context).textTheme.headline.copyWith(color: Colors.red)
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text('Enter a location to see the conditions there', 
                    style: Theme.of(context).textTheme.headline
                  )
                );
              }
            }
          ),
          FutureBuilder<MoonData>(
            future: _moonData,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Container(child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Moon Details'),
                          ),
                          body: MoonCard(snapshot.data)
                        );
                      },
                    ));
                  },
                  child: MoonCard(snapshot.data),
                );
              } else if(snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.exclamationCircle, color: Colors.red),
                      Text('Error loading moon data: ${snapshot.error}',
                        style: Theme.of(context).textTheme.headline.copyWith(color: Colors.red)
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }
          ),
          GestureDetector(
            child: Text('About this app',
              style: Theme.of(context).textTheme.body1.copyWith(decoration: TextDecoration.underline),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return About();
                },
              ));
            },
          )
        ]
      ),
    );
  }
}
