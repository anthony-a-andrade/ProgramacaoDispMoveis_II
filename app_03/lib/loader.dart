import 'dart:convert';

import 'package:app_03/helpers/currency_helper.dart';
import 'package:app_03/models/currency.dart';
import 'package:app_03/services/api_service.dart';
import 'package:app_03/views/error.dart';
import 'package:app_03/views/home.dart';
import 'package:app_03/views/splash.dart';
import 'package:flutter/cupertino.dart';

class Loader extends StatefulWidget {
  const Loader({ Key? key }) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  Future<String?> pegarDados() async { 
    return Future.delayed(const Duration(seconds: 2), () async => await APIService.getBody());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pegarDados(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none: case ConnectionState.waiting: return const Splash();
          default:
            List<Currency>? currencies = CurrencyHelper.getCurrencies(snapshot.data.toString());
            if (snapshot.hasError || currencies == null) return Error(json.decode(snapshot.data.toString())["message"]);
            return Home(currencies);
        }
      }
    );
  }
}