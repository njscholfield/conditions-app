import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoonData extends StatelessWidget {
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final String moonPhaseDesc;
  final DateTime date;

  MoonData({required this.moonrise, required this.moonset, required this.moonPhase, required this.moonPhaseDesc, required this.date});

  factory MoonData.fromJson(Map<String, dynamic> json) {
    String calculatePhase(double moonPhase) {
      double percent = (moonPhase < 0) ? moonPhase * -100 : moonPhase * 100;
      return '${percent.toStringAsPrecision(3)}%';
    }

    String addSpace(String time) {
      if(time == '*') {
        return '---';
      }
      return time.substring(0, time.length - 2) + ' ' + time.substring(time.length - 2);
    }

    return new MoonData(
      moonrise: addSpace(json['moonrise']),
      moonset: addSpace(json['moonset']),
      moonPhase: calculatePhase(json['moonPhase'].toDouble()),
      moonPhaseDesc: json['moonPhaseDesc'],
      date: DateTime.parse(json['utcTime'])
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Tooltip(
                      message: 'Moonrise',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.blueGrey[600],
                              size: 40
                            ),
                            Icon(
                              FontAwesomeIcons.upLong,
                              color: Colors.black
                            ),
                          ]
                        ),
                      ),
                    ),
                    Text(
                      moonrise,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ]
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Tooltip(
                      message: 'Moonset',
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.blueGrey[600],
                              size: 40,
                            ),
                            Icon(
                              FontAwesomeIcons.downLong,
                              color: Colors.black
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      moonset,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Tooltip(
                      message: '% Full',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                        child: Text(
                          moonPhase,
                          style: TextStyle(color: Colors.teal, fontSize: 30)
                        ),
                      ),
                    ),
                    Padding(
                      padding: (moonPhaseDesc.length < 10) ? const EdgeInsets.all(0) : const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        moonPhaseDesc,
                        style: (moonPhaseDesc.length < 10) ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                        // style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
      ],
    );
  }
}