import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:conditions/SunCard.dart';
import 'package:conditions/MoonCard.dart';

import 'package:conditions/AstronData.dart';

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
          )
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
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
          new FutureBuilder<AstronData>(
            future: _astronData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: <Widget>[
                    new SunCard(snapshot.data),
                    new MoonCard(snapshot.data),
                  ]
                );
              } else {
                return new Center(
                  child: new Text('Loading...', style: Theme.of(context).textTheme.headline)
                );
              }
            }
          )
        ]
      ),
    );
  }
}
