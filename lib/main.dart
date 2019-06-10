import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
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
  bool firstRun;
  bool locUsed;
  bool invalidLoc;
  final TextEditingController locationController = TextEditingController();
  Geolocator geolocator = Geolocator();

  Future<AstronData> fetchInfo({Position coords, String location}) async {
    List<Placemark> placemark;
    if(coords != null) {
      placemark = await Geolocator().placemarkFromCoordinates(coords.latitude, coords.longitude);
    } else {
      try {
        placemark = await Geolocator().placemarkFromAddress(location);
      } catch (PlatformException) {
        setState(() {
          invalidLoc = true;
        });
        return null;
      }
      coords = placemark[0].position;
    }

    final DateTime TODAY = DateTime.now();
    final String today = DateFormat.yMd().format(TODAY);
    final String placeName = '${placemark[0].locality}, ${placemark[0].administrativeArea}';
    final String coordsStr = '${coords.latitude},${coords.longitude}';
    final tz = TODAY.timeZoneOffset.inHours;
    locationController.text = placeName;

    final response = await http
        .get('https://api.usno.navy.mil/rstt/oneday?date=$today&coords=$coordsStr&tz=$tz');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON)
      setState(() {
        invalidLoc = false;
      });
      return AstronData.fromJson(json.decode(response.body), context);
    } else {
      setState(() {
        invalidLoc = true;
      });
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    firstRun = false;
    locUsed = false;
    invalidLoc = false;
    locationController.text = 'Pittsburgh, PA';
    _astronData = fetchInfo(location: 'Pittsburgh, PA');
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Prevent fetchInfo from running twice for page version
    if(!firstRun) {
      _astronData = fetchInfo(location: locationController.text);
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
              onSubmitted: (value) {
                setState(() {
                  locUsed = false;
                  _astronData = fetchInfo(location: value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter a location',
                prefix: new IconButton(
                  icon: new Icon(FontAwesomeIcons.locationArrow, color: locUsed ? Colors.blueAccent[700] : Colors.grey),
                  onPressed: () async {
                    final Position currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
                    setState(() {
                      locUsed = true;
                      _astronData = fetchInfo(coords: currentLocation);
                    });
                  },
                ),
                suffix: new IconButton(
                  icon: new Icon(FontAwesomeIcons.search),
                  onPressed: () {
                    setState(() {
                      locUsed = false;
                      _astronData = fetchInfo(location: locationController.text);
                    });
                    FocusScope.of(context).requestFocus(new FocusNode()); // Dismiss the keyboard
                  },
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: invalidLoc ? BorderSide(width: 2, color: Colors.red) : BorderSide(),
                ),
                errorText: invalidLoc ? 'Please enter a valid US location' : null
              ),
            ),
          ),
          new FutureBuilder<AstronData>(
            future: _astronData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Text(
                        DateFormat.yMMMMEEEEd().format(new DateTime.now()),
                        style: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new SunCard(snapshot.data),
                    new MoonCard(snapshot.data),
                  ]
                );
              } else if(snapshot.hasError) {
                return new Text("${snapshot.error}",
                  style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red)
                );
              } else {
                return new Center(child: new CircularProgressIndicator());
              }
            }
          )
        ]
      ),
    );
  }
}
