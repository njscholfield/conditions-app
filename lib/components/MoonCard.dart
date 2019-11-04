import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:conditions/models/AstronData.dart';

class MoonCard extends StatefulWidget {
  MoonCard(this.astronData);
  final AstronData astronData;

  MoonCardState createState() => new MoonCardState();
}

class MoonCardState extends State<MoonCard> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(MoonCard oldWidget) {
    if(oldWidget.astronData != widget.astronData) {
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
        color: Colors.blue[200],
        borderRadius: new BorderRadius.all(new Radius.circular(10.0))
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Moon', style: Theme.of(context).textTheme.display1),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Tooltip(
                    message: 'Moonrise',
                    child: new Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            FontAwesomeIcons.solidMoon,
                            color: Colors.blueGrey[600],
                            size: 40
                          ),
                          new Icon(
                            FontAwesomeIcons.longArrowAltUp,
                            color: Colors.black
                          ),
                        ]
                      ),
                    ),
                  ),
                  new Text(
                    widget.astronData.moonrise,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Tooltip(
                    message: 'Moonset',
                    child: new Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            FontAwesomeIcons.solidMoon,
                            color: Colors.blueGrey[600],
                            size: 40,
                          ),
                          new Icon(
                            FontAwesomeIcons.longArrowAltDown,
                            color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Text(
                    widget.astronData.moonset,
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value),
                  ),
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    widget.astronData.percentFull,
                    style: TextStyle(color: Colors.teal, fontSize: 40)
                  ),
                  new Text(
                    'Full',
                    style: Theme.of(context).textTheme.title.copyWith(color: _animation.value)
                  )
                ],
              ),
            ]
          ),
          new Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: new Text('Closest Phase', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black)),
          ),
          new Text('${widget.astronData.closestPhase}: ${widget.astronData.closestPhaseDate}', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}