import 'package:flutter/material.dart';

class AstronData {
  final String sunrise;
  final String sunset;
  final String dusk;
  final String moonrise;
  final String moonset;
  final String percentFull;
  final String closestPhase;
  final String closestPhaseDate;

  AstronData(
      {this.sunrise,
      this.sunset,
      this.dusk,
      this.moonrise,
      this.moonset,
      this.percentFull,
      this.closestPhase,
      this.closestPhaseDate});

  factory AstronData.fromJson(Map<String, dynamic> json, BuildContext context) {
    final Map<String, dynamic> astronInfo = json;
    final List<dynamic> sundata = astronInfo['sundata'];

    String cleanTime(time) {
      final timeComponents = time.split(':');
      final TimeOfDay timeofday = new TimeOfDay(hour: int.parse(timeComponents[0]), minute: int.parse(timeComponents[1]));
      return timeofday.format(context);
    }
    
    String moonData(String mode) {
      String time = '---';
      if(mode == 'R' && astronInfo['prevmoondata'] != null) {
        time = cleanTime(astronInfo['prevmoondata'][0]['time']) + ' (-1)';
      } else if(mode == 'S' && astronInfo['nextmoondata'] != null) {
        time =  cleanTime(astronInfo['nextmoondata'][0]['time']) + ' (+1)';
      } else {
        for (Map<String, dynamic> moondata in astronInfo['moondata']) {
          if(moondata['phen'] == mode) {
            time = cleanTime(moondata['time']);
            break;
          }
        }
      }
      return time;
    }

    String fracillum() {
      final Map<String, String> moonphases = {'First Quarter': '50%', 'Full Moon': '100%', 'Last Quarter': '50%', 'New Moon': '0%'};

      if(astronInfo['fracillum'] != null) {
        print("NULL");
        return astronInfo['fracillum'];
      } else {
        return moonphases[astronInfo['closestphase']['phase']];
      }
    }

    return AstronData(
      sunrise: cleanTime(sundata[1]['time']),
      sunset: cleanTime(sundata[3]['time']),
      dusk: cleanTime(sundata[4]['time']),
      moonrise: moonData('R'),
      moonset: moonData('S'),
      percentFull: fracillum(),
      closestPhase: astronInfo['closestphase']['phase'],
      closestPhaseDate: '${astronInfo['closestphase']['date']} at ${cleanTime(astronInfo['closestphase']['time'])}'
    );
  }
}