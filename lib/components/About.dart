import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:conditions/components/ClickableLink.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: new Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              child: new Icon(FontAwesomeIcons.code,
                size: 100.0,
                color: Colors.blue,
              ),
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            new Text('Sun and Moon data is provided by the Astronomical Applications API provided by the US Navy', style: Theme.of(context).textTheme.headline,),
            new ClickableLink(
              url: 'https://aa.usno.navy.mil/data/docs/api.php#rstt',
              child: new Text('API Documentation', style: Theme.of(context).textTheme.body2)
            ),
            new Spacer(),
            new Text('Built using Flutter', style: Theme.of(context).textTheme.headline,),
            new ClickableLink(
              url: 'https://flutter.io',
              child: Text('flutter.io', style: Theme.of(context).textTheme.body2)
            ),
            new Spacer(),
            new Text('Copyright © 2019 Noah Scholfield', style: Theme.of(context).textTheme.headline.copyWith(color: Colors.green)),
          ],
        ),
      )
    );
  }
}