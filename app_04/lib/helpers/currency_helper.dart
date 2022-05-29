import 'dart:convert';

import 'package:app_03/models/currency.dart';
import 'package:app_03/models/stock.dart';
import 'package:app_03/services/log_service.dart';

class CurrencyHelper {
  static final Map<String, String> _currencies = {
    "Dollar": "Dólar",
    "Pound Sterling": "Libra Esterlina",
    "Argentine Peso": "Peso Argentino",
    "Canadian Dollar": "Dólar Canadense",
    "Australian Dollar": "Dólar Australiano",
    "Japanese Yen": "Iene Japonês",
    "Renminbi": "Remimbi"
  };
  
  static final Map<String, String> _prefixes = {
    "BRL": "R\$",
    "USD": "USD\$",
    "EUR": "€",
    "GBP": "£",
    "ARS": "\$",
    "CAD": "CA\$",
    "AUD": "AU\$",
    "JPY": "¥",
    "CNY": "¥",
    "BTC": "BTC"
  };

  static String _getName(String by) => _currencies.containsKey(by) ? _currencies[by]! : by;
  static String _getPrefix(String by) => _prefixes[by]!;

  static List<Currency>? getCurrencies(String? body) {
    try {
      Map<String, dynamic> currencies = json.decode(body!)["results"]["currencies"];
      currencies.removeWhere((key, value) => key == "source");
      Map<String, Currency> filter = { "BRL": Currency("Real", "R\$", 1.0) };
      filter.addAll(currencies.map((String key, json) 
      {
        String name = _getName(json["name"]);
        String prefix = _getPrefix(key);
        double value = json["buy"];
        return MapEntry(key, Currency(name, prefix, value));
      }));

      Logger.info("CURRENCY-FILTER-SUCCESS");
      return filter.values.toList();
    } catch (e) { 
      Logger.error("ERROR-CURRENCY-FILTER: " + e.toString()); 
      return null;
    }
  }

  static List<Stock>? getStocks(String? body) {
    try {
      Map<String, dynamic> stocks = json.decode(body!)["results"]["stocks"];
      Map<String, Stock> filter = stocks.map((String key, json) {
        String name = json["name"];
        String location = json["location"];
        double points = json["points"];
        double variation = json["variation"];
        return MapEntry(key, Stock(name, key, location, variation, points));
      });
      Logger.info("STOCK-FILTER-SUCCESS");
      return filter.values.toList();
    } catch (e) {
      Logger.error("ERROR-STOCK-FILTER: " + e.toString()); 
      return null;
    }
  }
}