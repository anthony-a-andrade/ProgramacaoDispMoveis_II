import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/models/stock.dart';
import 'package:app_03/widgets/stock_text.dart';
import 'package:flutter/material.dart';

class HomeStocks extends StatefulWidget {
  final List<Stock> _stocks; 
  HomeStocks(this._stocks, { Key? key }) : super(key: key) {
    _stocks.sort((a, b) => a.Points.compareTo(b.Points));
  }

  @override
  State<HomeStocks> createState() => _HomeStocksState();
}

class _HomeStocksState extends State<HomeStocks> {
  Widget construirBolsas(BuildContext context, int index) {
    Stock stock = widget._stocks[index];    
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: StockText(
        name: stock.Name,
        shortName: stock.ShortName,
        location: stock.Location,
        points: stock.Points,
        variation: stock.Variation
      )
    );
  }

  int _modifier = 0;
  void modify(int? modifier) => setState(() {
    switch (modifier) {
      case 0: widget._stocks.sort((a, b) => a.Points.compareTo(b.Points)); break;
      case 1: widget._stocks.sort((a, b) => b.Points.compareTo(a.Points)); break;
      case 2: widget._stocks.sort((a, b) => a.Variation.compareTo(b.Variation)); break;
      case 3: widget._stocks.sort((a, b) => b.Variation.compareTo(a.Variation)); break;
      case 4: widget._stocks.sort((a, b) => a.ShortName.compareTo(b.ShortName)); break;
      case 5: widget._stocks.sort((a, b) => b.ShortName.compareTo(a.ShortName)); break;
    }
    _modifier = modifier!;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.trending_up_sharp, size: 150, color: Primary.Background),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ordenação:", style: Style.Bold.Size(14)),
                DropdownButton(
                  onChanged: modify, 
                  style: Style.Color(Colors.black),
                  value: _modifier,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("Pontos [Crescente]")),
                    DropdownMenuItem(value: 1, child: Text("Pontos [Decrescente]")),
                    DropdownMenuItem(value: 2, child: Text("Variação [Crescente]")),
                    DropdownMenuItem(value: 3, child: Text("Variação [Decrescente]")),
                    DropdownMenuItem(value: 4, child: Text("Nome [Crescente]")),
                    DropdownMenuItem(value: 5, child: Text("Nome [Decrescente]"))
                  ] 
                )
              ]
            )
          ]
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget._stocks.length,
          itemBuilder: construirBolsas
        )
      ]
    );
  }
}