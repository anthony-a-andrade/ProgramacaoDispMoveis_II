import 'package:app_03/helpers/style_helper.dart';
import 'package:flutter/material.dart';

class StockText extends StatelessWidget {
  final String name;
  final String shortName;
  final String location;
  final double points;
  final double variation;
  const StockText({ 
    required this.name, 
    required this.shortName, 
    required this.location, 
    required this.points, 
    required this.variation, 
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Divider(height: 10, color: Colors.black, thickness: 1)
        ),
        Text("$shortName - $name", style: Style.Bold.Size(24)),
        Text(location, style: Style.Size(17)),
        Row(
          children: [
            Row(
              children: [
                Text("Variação: ", style: Style.Bold),
                Text("${variation.toStringAsFixed(2)} %")
              ]
            ),
            const Spacer(),
            Row(
              children: [
                Text("Pontos: ", style: Style.Bold),
                Text(points.toStringAsFixed(2))
              ]
            )
          ]
        )
      ]
    );
  }
}