import 'package:flutter/material.dart';
import 'styles.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Contador de Alunos',
    debugShowCheckedModeBanner: false,
    home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _mensagem = "Entrada liberada!";
  int _pessoas = 0;
  final int _capacidade = 50;

  void atualizarPessoas(int valor)
  {
    setState(() {
      _pessoas += valor;
      
      if (_pessoas < 0)
      {
        _mensagem = "Não chegou ninguém ainda!";
        _pessoas = 0;
      }
      else if (_pessoas > _capacidade)
      {
        _mensagem = "Lotado!\nPor favor, aguarde!";
        _pessoas = _capacidade;
      }
      else 
      {
        _mensagem = "Entrada liberada!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(255, 101, 155, 255), 
          padding: const EdgeInsets.all(30),
          child: Container(
            foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/icone.png"),
                alignment: Alignment.bottomCenter
              )
            )
          )
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Pessoas: $_pessoas", style: title_font),
              Padding(
                padding: const EdgeInsets.all(15), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      child: const Icon(
                        Icons.add, 
                        color: Colors.black
                      ),
                      onPressed: (() => atualizarPessoas(1)),
                      style: button_style
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      child: const Icon(
                        Icons.remove, 
                        color: Colors.black
                      ),
                      onPressed: (() => atualizarPessoas(-1)),
                      style: button_style
                    )
                  ]
                )
              ),
              Text(
                _mensagem, 
                style: label_font, 
                textAlign: TextAlign.center
              )
            ]
          )
        )
      ]
    );
  }
}