import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/SunData.dart';

class SunCard extends StatefulWidget {
  SunCard(this.sunData);

  final SunData sunData;
  SunCardState createState() => new SunCardState();
}

class SunCardState extends State<SunCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;
  
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = new ColorTween(begin: Colors.blue, end: Colors.white).animate(_controller)..addListener((){
      setState(() {});
    });
    _controller.forward();

    super.initState();
  }

  @override
  void didUpdateWidget(SunCard oldWidget) {
    if(oldWidget.sunData != widget.sunData) {
      _controller.reset();
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Sun', style: Theme.of(context).textTheme.display1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Tooltip(
                    message: 'Sunrise',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidSun,
                            color: Colors.yellow[600],
                            size: 40
                          ),
                          Icon(
                            FontAwesomeIcons.longArrowAltUp,
                            color: Colors.black
                          ),
                        ]
                      ),
                    ),
                  ),
                  Text(
                    widget.sunData.sunrise,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Tooltip(
                    message: 'Sunset',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidSun,
                            color: Colors.yellow[800],
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.longArrowAltDown,
                            color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    widget.sunData.sunset,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Tooltip(
                    message: 'Civil Twilight End (Dusk)',
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Icon(
                        FontAwesomeIcons.solidBuilding,
                        color: Colors.blueGrey[600],
                        size: 40
                      )
                    ),
                  ),
                  Text(
                    widget.sunData.civilTwilightEnd,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ]
              ),
          ]),
        ],
      ),
    );
  }
}
