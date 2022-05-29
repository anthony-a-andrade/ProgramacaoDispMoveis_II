import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/widgets/center_text.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary.Foreground,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(flex: 3),
            const Icon(Icons.attach_money, color: Colors.black, size: 150),
            CenterText("Bolsa de Valores e Conversor de Moedas", style: Style.Bold.Size(25)),
            const Divider(height: 10, color: Colors.transparent, thickness: 2),
            Text("Carregando Dados...", style: Style.Size(18)),
            const Spacer(flex: 4)
          ]
        )
      )
    );
  }
}