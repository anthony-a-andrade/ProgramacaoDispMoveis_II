import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/models/currency.dart';
import 'package:app_03/models/stock.dart';
import 'package:app_03/views/home_currency.dart';
import 'package:app_03/views/home_stocks.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<Currency> _currencies;
  final List<Stock> _stocks;
  const Home(this._currencies, this._stocks, { Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _screen = 1;
  void change(int? screen) => setState(() => _screen = screen!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Primary.Background,
        centerTitle: true,
        title: Row(
          children: [
            TextButton(
              onPressed: (() => change(0)), 
              child: const Icon(Icons.arrow_left),
              style: Primary.ForegroundButtonStyle(_screen == 1)
            ),
            const Spacer(),
            Text(_screen == 0 ? "Conversor de Moedas v1.0" : "Bolsa de Valores", style: Style.Bold),
            const Spacer(),
            TextButton(
              onPressed: (() => change(1)), 
              child: const Icon(Icons.arrow_right),
              style: Primary.ForegroundButtonStyle(_screen == 0)
            )
          ]
        )
      ),
      backgroundColor: Secondary.Background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: _screen == 0,
              child: HomeCurrency(widget._currencies)
            ),
            Visibility(
              visible: _screen == 1,
              child: HomeStocks(widget._stocks)
            )
          ]
        )
      )
    );
  }
}