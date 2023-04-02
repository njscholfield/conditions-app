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
    this.attributionUrl,
    this.expireTime,
    this.latitude,
    this.longitude,
    this.readTime,
    this.reportedTime,
    this.units,
    this.version,
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
