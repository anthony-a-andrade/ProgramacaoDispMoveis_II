// ignore_for_file: non_constant_identifier_names

class Stock {
  final String _name;
  final String _shortName;
  final String _location;
  final double _points;
  final double _variation;

  Stock(this._name, this._shortName, this._location, this._variation, this._points);
  
  String get Name => _name;
  String get ShortName => _shortName;
  String get Location => _location;
  double get Points => _points;
  double get Variation => _variation;
}