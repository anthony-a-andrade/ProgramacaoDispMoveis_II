import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyTextField extends StatefulWidget {
  final String name;
  final String prefix;
  final double cotacao;
  final int value;
  final int modifier;
  final void Function([double? valor]) alterar;
  final void Function(int focused, String symbol, double value, TextEditingController controller) focar;

  const CurrencyTextField({
    required this.name, 
    required this.prefix, 
    required this.cotacao, 
    required this.value, 
    required this.focar, 
    required this.alterar, 
    required this.modifier, 
    Key? key,
  }) : super(key: key);

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  final TextEditingController _controller = TextEditingController();
  
  bool isFocused() => Currency.focusedAt == widget.value;
  bool otherFocused() {
    var result = !isFocused() && Currency.focusedAt != 0;
    if (result) _controller.clear();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  onTap: (() => widget.focar(widget.value, widget.prefix, widget.cotacao, _controller)),
                  onChanged: ((str) {
                    double? value = double.tryParse(str);
                    // ignore: curly_braces_in_flow_control_structures
                    if (value != null) widget.alterar(value * widget.cotacao); else widget.alterar();
                  }),
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: widget.name,
                    prefixText: widget.prefix,
                    labelStyle: Style.Bold.Color(isFocused() ? Primary.Background : Colors.black),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Primary.Background, width: 3))
                  )
                ),
              ),
              Visibility(
                visible: otherFocused(),
                child: Text(textoConversao(), style: Style.Bold.Size(13).Italic()),
              )
            ]
          )
        ),
        const Divider(color: Colors.transparent, height: 9),
        const Divider(color: Colors.black, height: 0, thickness: 1)
      ]
    );
  }

  String textoConversao() {
    double? entrada = Currency.conversionValue;
    double valorMoeda = Currency.currencyValue;
    String simboloMoeda = Currency.selectedCurrency;
    int modifier = widget.modifier;
    String prefixo = widget.prefix;
    double cotacao = widget.cotacao;

    double cotacao_;
    String result;

    if (modifier == 0) {
      cotacao_ = cotacao / valorMoeda;
      result = "$simboloMoeda ${cotacao_.toStringAsFixed(2)} p/ $prefixo";
    } else {
      cotacao_ = valorMoeda / cotacao;
      result = "$prefixo ${cotacao_.toStringAsFixed(2)} p/ $simboloMoeda";
    }

    return entrada == null ? result : "$prefixo ${(entrada / cotacao).toStringAsFixed(2)} ($result)";
  }
}