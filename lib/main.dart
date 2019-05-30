import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:conditions/AstronData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conditions',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.grey[800],
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
          display1: TextStyle(
            color: Colors.white,
          )
        ),
      ),
      home: MyHomePage(title: 'Conditions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<AstronData> _astronData;
  bool firstRun = true;
  final locationController = TextEditingController();
  String _location;

  Future<AstronData> fetchInfo() async {
    final response = await http
        .get('https://api.usno.navy.mil/rstt/oneday?date=today&loc=${_location}');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return AstronData.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    firstRun = false;
    _location = 'Pittsburgh, PA';
    locationController.text = _location;
    _astronData = fetchInfo();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Prevent fetchInfo from running twice for page version
    if(!firstRun) {
      _astronData = fetchInfo();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<AstronData>(
          future: _astronData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView(
                children: <Widget>[
                  // Search bar
                  new Container(
                    margin: EdgeInsets.all(10.0),
                    child: new TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Enter a location',
                        suffix: new IconButton(
                          icon: new Icon(FontAwesomeIcons.search),
                          onPressed: () {
                            setState(() {
                              _location = locationController.text;
                            });
                            _astronData = fetchInfo();
                          },
                        )
                      ),
                    ),
                  ),
                  // Sun Card
                  new Container(
                    decoration: new BoxDecoration(color: Colors.green[300]),
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        new Text('Sun', style: Theme.of(context).textTheme.display1),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(
                                        FontAwesomeIcons.solidSun,
                                        color: Colors.yellow[600],
                                        size: 40
                                      ),
                                      new Icon(FontAwesomeIcons.longArrowAltUp),
                                    ]
                                  ),
                                ),
                                new Text(
                                  snapshot.data.sunrise,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ]
                            ),
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(
                                        FontAwesomeIcons.solidSun,
                                        color: Colors.yellow[800],
                                        size: 40,
                                      ),
                                      new Icon(FontAwesomeIcons.longArrowAltDown),
                                    ],
                                  ),
                                ),
                                new Text(
                                  snapshot.data.sunset,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: new Icon(
                                    FontAwesomeIcons.solidMoon,
                                    color: Colors.blueGrey[600],
                                    size: 40
                                  )
                                ),
                                new Text(
                                  snapshot.data.dusk,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ]
                            ),
                        ]),
                      ],
                    ),
                  ),
                  // Moon Card
                  new Container(
                    decoration: new BoxDecoration(color: Colors.blue[200]),
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Column(
                      children: <Widget>[
                        new Text('Moon', style: Theme.of(context).textTheme.display1),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(
                                        FontAwesomeIcons.solidMoon,
                                        color: Colors.blueGrey[600],
                                        size: 40
                                      ),
                                      new Icon(FontAwesomeIcons.longArrowAltUp),
                                    ]
                                  ),
                                ),
                                new Text(
                                  snapshot.data.moonrise,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ]
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(
                                        FontAwesomeIcons.solidMoon,
                                        color: Colors.blueGrey[600],
                                        size: 40,
                                      ),
                                      new Icon(FontAwesomeIcons.longArrowAltDown),
                                    ],
                                  ),
                                ),
                                new Text(
                                  snapshot.data.moonset,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ],
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  snapshot.data.percentFull,
                                  // style: Theme.of(context).textTheme.display1,
                                  style: TextStyle(color: Colors.teal, fontSize: 40)
                                ),
                                new Text(
                                  'Full',
                                  style: Theme.of(context).textTheme.title
                                )
                              ],
                            ),
                          ]
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Text('Closest Phase', style: Theme.of(context).textTheme.headline),
                        ),
                        new Text('${snapshot.data.closestPhase}: ${snapshot.data.closestPhaseDate}'),
                      ],
                    ),
                  ),
                ]
              );
            } else {
              return new Text('Loading...');
            }
          }
        )
      ),
    );
  }
}
