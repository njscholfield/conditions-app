// WeatherKit always returns metric data (ºC, km/h). These helpers convert it
// to the unit system selected in Settings.
class Units {
  static const int canada = 1; // ºC, kph
  static const int uk = 2; // ºC, mph
  static const int us = 3; // ºF, mph
  static const int si = 4; // ºC, m/s

  static double temperature(double celsius, int unitIdx) {
    return unitIdx == us ? celsius * 9 / 5 + 32 : celsius;
  }

  static double speed(double kph, int unitIdx) {
    switch (unitIdx) {
      case uk:
      case us:
        return kph / 1.609344;
      case si:
        return kph / 3.6;
      default:
        return kph;
    }
  }

  static String speedLabel(int unitIdx) {
    switch (unitIdx) {
      case uk:
      case us:
        return 'mph';
      case si:
        return 'm/s';
      default:
        return 'kph';
    }
  }
}
