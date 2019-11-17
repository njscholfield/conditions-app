import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:conditions/models/SunData.dart';
import 'package:conditions/models/MoonData.dart';

class LocationField extends StatefulWidget {
  LocationField(this.updateSunData, this.updateMoonData, this.updateDarkSkyData, this.updateUnitIdx);

  final Function(Future<SunData>) updateSunData;
  final Function(Future<List<MoonData>>) updateMoonData;
  final Function(Future<Forecast>) updateDarkSkyData;
  final Function(int) updateUnitIdx;
  _LocationFieldState createState() => new _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  bool locUsed;
  final TextEditingController locationController = TextEditingController();
  Geolocator geolocator = Geolocator();
  bool invalidLoc;
  String _darkSkyKey;
  String _hereAppId;
  String _hereAppCode;

  // Load in the Dark Sky API Key from the config file
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }

  // Assign key to variable
  _LocationFieldState() {
    loadAsset().then((val) => setState(() {
        final Map<String, dynamic> data = jsonDecode(val);
        _darkSkyKey = data['dark_sky_key'];
        _hereAppId = data['here_app_id'];
        _hereAppCode = data['here_app_code'];
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
        widget.updateSunData(Future<SunData>.value(null));
        widget.updateMoonData(Future<List<MoonData>>.value(null));
        widget.updateDarkSkyData(Future<Forecast>.value(null));
        return null;
      }
      coords = placemark[0].position;
    }
    widget.updateSunData(callSunAPI(coords, placemark[0]));
    widget.updateMoonData(callMoonApi(coords));
    widget.updateDarkSkyData(callDarkSkyAPI(coords));
  }

  Future<SunData> callSunAPI(Position coords, Placemark placemark) async {
    final String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final String placeName = '${placemark.locality}, ${placemark.administrativeArea}';
    locationController.text = placeName;

    final response = await http.get('https://api.sunrise-sunset.org/json?lat=${coords.latitude}&lng=${coords.longitude}&date=$today&formatted=0');

    if (response.statusCode == 200) {
      setState(() {
        invalidLoc = false;
      });
      return SunData.fromJson(json.decode(response.body));
    } else {
      setState(() {
        invalidLoc = true;
      });
      return null;
    }
  }

  Future<List<MoonData>> callMoonApi(Position coords) async {
    final response = await http.get('https://weather.cit.api.here.com/weather/1.0/report.json?product=forecast_astronomy&latitude=${coords.latitude}&longitude=${coords.longitude}&app_id=$_hereAppId&app_code=$_hereAppCode');

    if(response.statusCode == 200) {
      final List<MoonData> moonDataList = new List();
      final List<dynamic> jsonList = json.decode(response.body)['astronomy']['astronomy'];
      for (Map<String, dynamic> item in jsonList) {
        moonDataList.add(MoonData.fromJson(item));
      }
      return moonDataList;
    } else {
      return Future.error('Unable to fetch moon data');
    }
  }

  Future<Forecast> callDarkSkyAPI(Position coords) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int unitIdx = (prefs.getInt('unit') ?? 3);
    widget.updateUnitIdx(unitIdx);
    var darksky = new DarkSkyWeather(_darkSkyKey,
      language: Language.English, units: Units.values[unitIdx]);
    var forecast = await darksky.getForecast(coords.latitude, coords.longitude);

    if(forecast.currently == null) {
      return Future.error('Error loading Dark Sky data');
    }
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
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextField(
        controller: locationController,
        onSubmitted: (value) {
          setState(() {
            locUsed = false;
          });
          fetchInfo(location: value);
        },
        decoration: InputDecoration(
          labelText: 'Enter a location',
          prefix: IconButton(
            icon: Icon(FontAwesomeIcons.locationArrow, color: locUsed ? Colors.blueAccent[700] : Colors.grey),
            onPressed: () async {
              final Position currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
              setState(() {
                locUsed = true;
              });
              fetchInfo(coords:currentLocation);
              FocusScope.of(context).requestFocus(new FocusNode()); // Dismiss the keyboard
            },
          ),
          suffix: IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {
              setState(() {
                locUsed = false;
              });
              fetchInfo(location: locationController.text);
              FocusScope.of(context).requestFocus(new FocusNode()); // Dismiss the keyboard
            },
          ),
          errorBorder: OutlineInputBorder(
            borderSide: invalidLoc ? BorderSide(width: 2, color: Colors.red) : BorderSide(),
          ),
          errorText: invalidLoc ? 'Please enter a valid US location' : null
        ),
      ),
    );
  }
}