import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableLink extends StatelessWidget {
  ClickableLink({this.url, this.child});

  final String url;
  final Widget child;

  _launchURL(url) async {
    Uri myurl = Uri.parse(url);
    if (await canLaunchUrl(myurl)) {
      await launchUrl(myurl);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: child
    );
  }
}