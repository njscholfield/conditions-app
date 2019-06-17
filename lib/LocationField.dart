import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:conditions/AstronData.dart';

class LocationField extends StatefulWidget {
  LocationField(this.callback);

  final Function(Future<AstronData>) callback;
  _LocationFieldState createState() => new _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  bool locUsed;
  final TextEditingController locationController = TextEditingController();
  Geolocator geolocator = Geolocator();
  bool invalidLoc;

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

    final DateTime todayObj = DateTime.now();
    final String today = DateFormat.yMd().format(todayObj);
    final String placeName = '${placemark[0].locality}, ${placemark[0].administrativeArea}';
    final String coordsStr = '${coords.latitude},${coords.longitude}';
    final tz = todayObj.timeZoneOffset.inHours;
    locationController.text = placeName;

    final response = await http.get('https://api.usno.navy.mil/rstt/oneday?date=$today&coords=$coordsStr&tz=$tz');  

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
    locUsed = false;
    invalidLoc = false;
    locationController.text = 'Pittsburgh, PA';
    // widget.callback(fetchInfo(location: 'Pittsburgh, PA'));
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
            widget.callback(fetchInfo(location: value));
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
                widget.callback(fetchInfo(coords: currentLocation));
              });
            },
          ),
          suffix: new IconButton(
            icon: new Icon(FontAwesomeIcons.search),
            onPressed: () {
              setState(() {
                locUsed = false;
                widget.callback(fetchInfo(location: locationController.text));
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
    );
  }
}