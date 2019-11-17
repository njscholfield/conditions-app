class MoonData {
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final String moonPhaseDesc;
  final DateTime date;

  MoonData({this.moonrise, this.moonset, this.moonPhase, this.moonPhaseDesc, this.date});

  factory MoonData.fromJson(Map<String, dynamic> json) {
    String calculatePhase(double moonPhase) {
      double percent = (moonPhase < 0) ? moonPhase * -100 : moonPhase * 100;
      return '$percent%';
    }

    return new MoonData(
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: calculatePhase(json['moonPhase']),
      moonPhaseDesc: json['moonPhaseDesc'],
      date: DateTime.parse(json['utcTime'])
    );
  }
}