import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:darksky_weather/darksky_weather_io.dart';

class DarkSky extends StatefulWidget {
  DarkSky(this.coords);
  final Position coords;

  DarkSkyState createState() => new DarkSkyState();
}

class DarkSkyState extends State<DarkSky> {
  Future<Forecast> _forecast;

  Future<Forecast> getForecast() async {
    var darksky = new DarkSkyWeather("fbf37604c9e43f23cfec01e137f2004f",
      language: Language.English, units: Units.SI);
    var forecast = await darksky.getForecast(widget.coords.latitude, widget.coords.longitude);

    return forecast;
  }

  @override
  void initState() {
    if(widget.coords != null) {
      setState(() {
        _forecast = getForecast();
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(DarkSky oldWidget) {
    if(widget.coords != null && widget.coords != oldWidget.coords) {
      setState(() {
        _forecast = getForecast();
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(228, 87, 46, .95),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FutureBuilder<Forecast>(
            future: _forecast,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Text(snapshot.data.currently.temperature.round().toString() + 'º',
                              style: Theme.of(context).textTheme.display1.copyWith(color: Colors.green[300]),
                            ),
                            new Text(snapshot.data.currently.summary,
                              style: Theme.of(context).textTheme.title
                            )
                          ],
                        ),
                        new Column(
                          children: <Widget>[
                            new Text('${(snapshot.data.currently.precipProbability * 100).round()}%',
                              style: TextStyle(color: Colors.blue[200], fontSize: 40)
                            ),
                            new Text('Precip',
                              style: Theme.of(context).textTheme.title,
                            )
                          ],
                        )
                      ],
                    ),
                    new Divider(color: Colors.white),
                    new Text('Next Hour: ${snapshot.data.minutely.summary}',
                      style: Theme.of(context).textTheme.title,
                    )
                  ]
                );
              } else {
                return new Text('Waiting for weather data...');
              }
            }
          ),
        ],
      )
    );
  }

}