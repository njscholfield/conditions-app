import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  SettingsState createState() => new SettingsState();
}

class SettingsState extends State<Settings> {
  int dropdownValue = 3;

  void fetchCurrentUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int unit = (prefs.getInt('unit') ?? 3);
    setState(() {
      dropdownValue = unit;
    });
  }

  void setUnit(int unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('unit', unit);
  }

  @override
  void initState() {
    fetchCurrentUnit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Select the units you would like:'),
              DropdownButton<int>(
                value: dropdownValue,
                onChanged: (int? newValue) {
                  if(newValue == null) return;
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <Map<String, dynamic>>[{'value': 3, 'text': 'US (ºF, mph)'}, {'value': 4, 'text': 'SI (ºC, m/s)'}, {'value': 1, 'text': 'Canada (ºC, kph)'}, {'value': 2, 'text': 'UK (ºC, mph)'}]
                  .map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
                    return DropdownMenuItem<int>(
                      value: item['value'],
                      child: Text(item['text']),
                    );
                  })
                  .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  setUnit(dropdownValue);
                  Navigator.pop(context);
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue)
              )
            ],
          )
        )
      )
    );
  }
}