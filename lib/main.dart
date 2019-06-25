import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

import 'package:conditions/components/DarkSky.dart';
import 'package:conditions/components/DarkSkyExpanded.dart';
import 'package:conditions/components/SunCard.dart';
import 'package:conditions/components/MoonCard.dart';
import 'package:conditions/components/LocationField.dart';
import 'package:conditions/components/About.dart';

import 'package:conditions/models/AstronData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conditions',
      theme: ThemeData(
        primaryColor: Colors.grey[800],
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
          display1: TextStyle(
            color: Colors.white,
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
  Future<AstronData> _astronData;
  Future<Forecast> _darkSky;

  void updateAstronData(Future<AstronData> newAstronData) {
    setState(() {
      _astronData = newAstronData;
    });
  }

  void updateDarkSkyData(Future<Forecast> newDarkSky) {
    setState(() {
      _darkSky = newDarkSky;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          new LocationField(updateAstronData, updateDarkSkyData),
          new FutureBuilder<AstronData>(
            future: _astronData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Text(
                        'Updated: ${DateFormat.MMMMEEEEd().add_jm().format(new DateTime.now())}',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new DarkSkyExpanded(_darkSky);
                          },
                        ));
                      },
                      child: new DarkSky(_darkSky),
                    ),
                    new GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new Scaffold(
                              appBar: AppBar(
                                title: Text('Sun Details'),
                              ),
                              body: SunCard(snapshot.data)
                            );
                          },
                        ));
                      },
                      child: new SunCard(snapshot.data),
                    ),
                    new GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new Scaffold(
                              appBar: AppBar(
                                title: Text('Moon Details'),
                              ),
                              body: MoonCard(snapshot.data)
                            );
                          },
                        ));
                      },
                      child: new MoonCard(snapshot.data),
                    ),
                    new GestureDetector(
                      child: Text('About this app',
                        style: Theme.of(context).textTheme.body1.copyWith(decoration: TextDecoration.underline)
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new About();
                          },
                        ));
                      },
                    )
                  ]
                );
              } else if(snapshot.hasError) {
                return new Text("${snapshot.error}",
                  style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red)
                );
              } else {
                return new Container(
                  margin: EdgeInsets.all(10.0),
                  child: new Text('Enter a location to see the conditions there', 
                    style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black)
                  )
                );
              }
            }
          )
        ]
      ),
    );
  }
}
