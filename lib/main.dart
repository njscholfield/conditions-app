import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:conditions/components/SunCard.dart';
import 'package:conditions/components/SunCardExpanded.dart';
import 'package:conditions/components/MoonCard.dart';
import 'package:conditions/components/MoonCardExpanded.dart';
import 'package:conditions/components/LocationField.dart';
import 'package:conditions/components/About.dart';
import 'package:conditions/components/Settings.dart';
import 'package:conditions/components/CurrentConditions.dart';
import 'package:conditions/components/CurrentConditionsExpanded.dart';

import 'package:conditions/models/SunData.dart';
import 'package:conditions/models/MoonData.dart';
import 'package:conditions/models/WeatherKit.dart';

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
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            decoration: TextDecoration.underline
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
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
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SunData?>? _sunData;
  Future<List<MoonData>?>? _moonData;
  Future<WeatherKitData?>? _weatherKit;

  void updateSunData(Future<SunData?> newSunData) {
    setState(() {
      _sunData = newSunData;
    });
  }

  void updateMoonData(Future<List<MoonData>?> newMoonData) {
    setState(() {
      _moonData = newMoonData;
    });
  }

  void updateWeatherKitData(Future<WeatherKitData?> newWeatherKit) {
    setState(() {
      _weatherKit = newWeatherKit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.gear),
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
          LocationField(updateSunData, updateMoonData, updateWeatherKitData),
          FutureBuilder<WeatherKitData?>(
            future: _weatherKit,
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
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            return CurrentConditionsExpanded(snapshot.data!, 1);
                          },
                        ));
                      },
                      child: CurrentConditions(snapshot.data!),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.circleExclamation,
                          color: Colors.red),
                      Text('Error loading Weather data',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.red))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }
          ),
          FutureBuilder<SunData?>(
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
                          body: SunCardExpanded(snapshot.data!)
                        );
                      },
                    ));
                  },
                  child: SunCard(snapshot.data!),
                );
              } else if(snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.circleExclamation, color: Colors.red),
                      Text('Error loading sun data',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red)
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text('Enter a location to see the conditions there', 
                    style: Theme.of(context).textTheme.headlineSmall
                  )
                );
              }
            }
          ),
          FutureBuilder<List<MoonData>?>(
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
                          body: MoonCardExpanded(snapshot.data!)
                        );
                      },
                    ));
                  },
                  child: MoonCard(snapshot.data![0]),
                );
              } else if(snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.circleExclamation, color: Colors.red),
                      Text('Error loading moon data: ${snapshot.error}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red)
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline),
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
