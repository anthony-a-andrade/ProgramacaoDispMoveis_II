// ignore_for_file: non_constant_identifier_names

class Currency {
  final String _name;
  final String _prefix;
  final double _value;

  Currency(this._name, this._prefix, this._value);
  
  String get Name => _name;
  String get Prefix => _prefix;
  double get Value => _value;

  static int focusedAt = 0;
  static double currencyValue = 0.0;
  static String selectedCurrency = "";
  static double? conversionValue;
}