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

  factory AstronData.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> astronInfo = json;
    final List<dynamic> sundata = astronInfo['sundata'];
    final List<dynamic> moondata = astronInfo['moondata'];

    String cleanTime(time) {
      return time.replaceAll('.', '').substring(0, time.lastIndexOf(' ') - 2).toUpperCase();
    }

    return AstronData(
      sunrise: cleanTime(sundata[1]['time']),
      sunset: cleanTime(sundata[3]['time']),
      dusk: cleanTime(sundata[4]['time']),
      moonrise: cleanTime(moondata[0]['time']),
      moonset: cleanTime(moondata[2]['time']),
      percentFull: astronInfo['fracillum'],
      closestPhase: astronInfo['closestphase']['phase'],
      closestPhaseDate: '${astronInfo['closestphase']['date']} at ${cleanTime(astronInfo['closestphase']['time'])}'
    );
  }
}