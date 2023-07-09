class Metadata {
  final String attributionUrl;
  final DateTime expireTime;
  final double latitude;
  final double longitude;
  final DateTime readTime;
  final DateTime reportedTime;
  final String units;
  final int version;

  Metadata({
    required this.attributionUrl,
    required this.expireTime,
    required this.latitude,
    required this.longitude,
    required this.readTime,
    required this.reportedTime,
    required this.units,
    required this.version,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      attributionUrl: json['attributionURL'],
      expireTime: DateTime.parse(json['expireTime']),
      latitude: json['latitude'],
      longitude: json['longitude'],
      readTime: DateTime.parse(json['readTime']),
      reportedTime: DateTime.parse(json['reportedTime']),
      units: json['units'],
      version: json['version'],
    );
  }
}
