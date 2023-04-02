import 'package:flutter/material.dart';
import 'package:conditions/models/MoonData.dart';

class MoonCard extends StatelessWidget {
  MoonCard(this.moonData);

  final MoonData moonData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Moon', style: Theme.of(context).textTheme.headlineMedium),
          moonData,
        ],
      ),
    );
  }
}