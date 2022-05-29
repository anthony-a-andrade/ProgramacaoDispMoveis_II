import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/models/currency.dart';
import 'package:app_03/widgets/center_text.dart';
import 'package:app_03/widgets/currency_text_field.dart';
import 'package:app_03/widgets/radio_text.dart';
import 'package:flutter/material.dart';

class HomeCurrency extends StatefulWidget {
  final List<Currency> _currencies;
  const HomeCurrency(this._currencies, { Key? key }) : super(key: key);

  @override
  State<HomeCurrency> createState() => _HomeCurrencyState();
}

class _HomeCurrencyState extends State<HomeCurrency> {
  int _modifier = 0;
  void modify(int? modifier) => setState(() => _modifier = modifier!);

  void alterar([double? valorConversao]) => setState(() => Currency.conversionValue = valorConversao);
  void limpar() => focar(0, "", 0.0);
  TextEditingController? controller;
  void focar(int foco, String moedaSelecionada, double valorCotacao, [TextEditingController? controller]) {
    alterar();
    setState(() {
      this.controller?.clear();
      this.controller = controller;
      Currency.focusedAt = foco;
      Currency.currencyValue = valorCotacao;
      Currency.selectedCurrency = moedaSelecionada;
    });
  }
  
  Widget construirMoedas(BuildContext context, int index) {
    Currency currency = widget._currencies[index];    
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: CurrencyTextField(
        name: currency.Name, 
        prefix: currency.Prefix, 
        cotacao: currency.Value, 
        value: index + 1, 
        focar: focar, 
        alterar: alterar, 
        modifier: _modifier
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.monetization_on, size: 150, color: Primary.Background),
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Modo de Exibição:", style: Style.Bold.Size(14)),
                RadioText("Cotação por Moeda", 0, _modifier, modify),
                RadioText("Moeda para Cotação", 1, _modifier, modify)
              ]
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: TextButton(
                onPressed: limpar,
                child: CenterText("Limpar\nCampos", style: Style.Bold)
              )
            )
          ]
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget._currencies.length,
          itemBuilder: construirMoedas
        )
      ]
    );
  }
}