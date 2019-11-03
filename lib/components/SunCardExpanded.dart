import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/SunData.dart';

class SunCardExpanded extends StatefulWidget {
  SunCardExpanded(this.sunData);

  final SunData sunData;
  SunCardExpandedState createState() => new SunCardExpandedState();
}

class SunCardExpandedState extends State<SunCardExpanded> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(SunCardExpanded oldWidget) {
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
      decoration: new BoxDecoration(
        color: Colors.green[300],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        new Icon(
                          FontAwesomeIcons.longArrowAltUp,
                          color: Colors.black
                        ),
                      ]
                    ),
                  ),
                  new Text(
                    widget.sunData.sunrise,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
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
                        new Icon(
                          FontAwesomeIcons.longArrowAltDown,
                          color: Colors.black
                        ),
                      ],
                    ),
                  ),
                  new Text(
                    widget.sunData.sunset,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
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
                    widget.sunData.civilTwilightEnd,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ]
              ),
          ]),
          new Divider(color: Colors.white),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, right: 12.0),
                    child: new Icon(
                      FontAwesomeIcons.stopwatch,
                      color: Colors.indigoAccent,
                      size: 40
                    ),
                  ),
                  new Text(
                    '${widget.sunData.dayLength}',
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
