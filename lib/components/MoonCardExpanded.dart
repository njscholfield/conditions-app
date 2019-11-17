import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:conditions/models/MoonData.dart';

class MoonCardExpanded extends StatelessWidget {
  MoonCardExpanded(this.moonData);

  final List<MoonData> moonData;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: moonData.length,
      itemBuilder: (_, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: const BorderRadius.all(Radius.circular(10.0))
          ),
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              Text(DateFormat.yMEd().format(moonData[index].date)),
              moonData[index],
            ],
          ),
        );
      }
    );
  }
}