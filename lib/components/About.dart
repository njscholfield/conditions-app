import 'package:flutter/material.dart';

import 'package:conditions/components/ClickableLink.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sun data is provided by Sunrise-Sunset', style: Theme.of(context).textTheme.headlineSmall),
            ClickableLink(
              url: 'https://sunrise-sunset.org/api',
              child: Text('API Documentation', style: Theme.of(context).textTheme.bodyLarge)
            ),
            Spacer(),
            Text('Moon data is provided by HERE', style: Theme.of(context).textTheme.headlineSmall),
            ClickableLink(
              url: 'https://developer.here.com/documentation/destination-weather/dev_guide/topics/example-astronomy-forecast.html',
              child: Text('API Documentation', style: Theme.of(context).textTheme.bodyLarge)
            ),
            Spacer(),
            Text('Weather data is provided by  Weather', style: Theme.of(context).textTheme.headlineSmall),
            ClickableLink(
              url: 'https://developer.apple.com/weatherkit/',
              child: Text(' Weather API', style: Theme.of(context).textTheme.bodyLarge)
            ),
            Spacer(),
            Text('Built using Flutter', style: Theme.of(context).textTheme.headlineSmall),
            ClickableLink(
              url: 'https://flutter.dev',
              child: Text('flutter.dev', style: Theme.of(context).textTheme.bodyLarge)
            ),
            Spacer(),
            Text('Copyright © 2023 Noah Scholfield', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.green)),
          ],
        ),
      )
    );
  }
}