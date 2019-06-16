import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/AstronData.dart';

class SunCard extends StatefulWidget {
  SunCard(this.astronData);

  final AstronData astronData;
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
    _controller.reset();
    _controller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return new Scaffold(
              appBar: AppBar(
                title: Text('Sun Details'),
              ),
              body: SunCard(widget.astronData)
            );
          },
        ));
      },
      child: new Container(
        decoration: new BoxDecoration(color: Colors.green[300]),
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
                          new Icon(FontAwesomeIcons.longArrowAltUp),
                        ]
                      ),
                    ),
                    new Text(
                      widget.astronData.sunrise,
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
                          new Icon(FontAwesomeIcons.longArrowAltDown),
                        ],
                      ),
                    ),
                    new Text(
                      widget.astronData.sunset,
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
                      widget.astronData.dusk,
                      style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                    ),
                  ]
                ),
            ]),
          ],
        ),
      ),
    );
  }
}
