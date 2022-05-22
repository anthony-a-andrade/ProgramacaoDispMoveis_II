import 'package:app_03/helpers/style_helper.dart';
import 'package:app_03/widgets/center_text.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String message;
  const Error(this.message, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primary.Foreground,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 3),
            const Icon(Icons.block, color: Colors.black, size: 150),
            CenterText("Erro ao carregar\nos dados!", style: Style.Bold.Size(20)),
            const Spacer(flex: 4),
            CenterText(message, style: Style.Size(16)),
            const Spacer(flex: 1)
          ]
        )
      )
    );
  }
}