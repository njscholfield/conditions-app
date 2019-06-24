import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:conditions/models/AstronData.dart';

class LocationField extends StatefulWidget {
  LocationField(this.updateAstronData, this.updateDarkSkyData);

  final Function(Future<AstronData>) updateAstronData;
  final Function(Future<Forecast>) updateDarkSkyData;
  _LocationFieldState createState() => new _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  bool locUsed;
  final TextEditingController locationController = TextEditingController();
  Geolocator geolocator = Geolocator();
  bool invalidLoc;
  String _darkSkyKey;

  // Load in the Dark Sky API Key from the config file
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }

  // Assign key to variable
  _LocationFieldState() {
    loadAsset().then((val) => setState(() {
        _darkSkyKey = jsonDecode(val)['dark_sky_key'];
      })
    );
  }

  void fetchInfo({Position coords, String location}) async {
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
        widget.updateAstronData(Future<AstronData>.value(null));
        widget.updateDarkSkyData(Future<Forecast>.value(null));
        return null;
      }
      coords = placemark[0].position;
    }
    widget.updateAstronData(callAstronAPI(coords, placemark[0]));
    widget.updateDarkSkyData(callDarkSkyAPI(coords));
  }

  Future<AstronData> callAstronAPI(Position coords, Placemark placemark) async {
    final DateTime todayObj = DateTime.now();
    final String today = DateFormat.yMd().format(todayObj);
    final String placeName = '${placemark.locality}, ${placemark.administrativeArea}';
    final String coordsStr = '${coords.latitude},${coords.longitude}';
    final tz = todayObj.timeZoneOffset.inHours;
    locationController.text = placeName;

    final response = await http.get('https://api.usno.navy.mil/rstt/oneday?date=$today&coords=$coordsStr&tz=$tz');  

    if (response.statusCode == 200) {
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

  Future<Forecast> callDarkSkyAPI(Position coords) async {
    var darksky = new DarkSkyWeather(_darkSkyKey,
      language: Language.English, units: Units.SI);
    var forecast = await darksky.getForecast(coords.latitude, coords.longitude);
    return forecast;
  }

  @override
  void initState() {
    locUsed = false;
    invalidLoc = false;
    locationController.text = 'Pittsburgh, PA';
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10.0),
      child: new TextField(
        controller: locationController,
        onSubmitted: (value) {
          setState(() {
            locUsed = false;
          });
          fetchInfo(location: value);
        },
        decoration: InputDecoration(
          labelText: 'Enter a location',
          prefix: new IconButton(
            icon: new Icon(FontAwesomeIcons.locationArrow, color: locUsed ? Colors.blueAccent[700] : Colors.grey),
            onPressed: () async {
              final Position currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
              setState(() {
                locUsed = true;
              });
              fetchInfo(coords:currentLocation);
            },
          ),
          suffix: new IconButton(
            icon: new Icon(FontAwesomeIcons.search),
            onPressed: () {
              setState(() {
                locUsed = false;
              });
              fetchInfo(location: locationController.text);
              FocusScope.of(context).requestFocus(new FocusNode()); // Dismiss the keyboard
            },
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: invalidLoc ? BorderSide(width: 2, color: Colors.red) : BorderSide(),
          ),
          errorText: invalidLoc ? 'Please enter a valid US location' : null
        ),
      ),
    );
  }
}