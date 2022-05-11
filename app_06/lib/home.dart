// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_06/styleHelper.dart';
import 'package:app_06/fileService.dart';
import 'package:app_06/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tarefa> _tarefas = [];
  List<Tarefa> _tarefasBackup = [];
  late Tarefa _tarefaRemovida;
  late int _tarefaPosicao;
  
  bool _addForm = true, _filterForm = false;
  int _modifier = 0;

  final _filtroController = TextEditingController();
  final _tituloController = TextEditingController();
  final _subtituloController = TextEditingController();

  @override 
  void initState() {
    super.initState();
    FileService.ObterDados().then((data) => setState(() {
      Iterable tarefas = json.decode(data!);
      _tarefas = List<Tarefa>.from(tarefas.map((t) => Tarefa.fromJson(t)).toList());
    }));

    _filtroController.addListener(() => FiltrarTarefas(_modifier));
  }

  void AlternarEstados()
  {
    setState(() {
      _addForm = !_addForm;
      _filterForm = !_filterForm;
      FiltrarTarefas(0);

      for (var controller in [_tituloController, _subtituloController, _filtroController])
        controller.text = "";
    });
  }
  
  void AdicionarTarefa()
  {
    setState(() { 
      String title = _tituloController.text;
      String subtitle = _subtituloController.text;
      Tarefa novaTarefa = Tarefa(title, subtitle);
      // log("novaTarefa");

      _tituloController.text = "";
      _subtituloController.text = "";
      _tarefas.add(novaTarefa);
      // log("add");
      FileService.SalvarDados(_tarefas);
      // log("save\n");
    });
  }

  void FiltrarTarefas(int modifier)
  {
    setState(() {
      _modifier = modifier;

      String filtro = _filtroController.text;
      if (_tarefasBackup.isEmpty) _tarefasBackup = _tarefas;
      else if (_tarefas.isEmpty || filtro.isEmpty || _tarefasBackup.isNotEmpty) _tarefas = _tarefasBackup;

      var tarefasFiltro = _tarefas
        .where((t) => filtro.isEmpty ? true : t.Title.contains(filtro) || t.Subtitle.contains(filtro))
        .where((t) => _modifier == 0 ? true : _modifier == 1 ? t.State : !t.State)
        .toList();

      _tarefas = tarefasFiltro;
      if (tarefasFiltro.isEmpty)
      {
        Fluttertoast.showToast(
          msg: "Nenhuma tarefa encontrada.", 
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Primary.Background,
          gravity: ToastGravity.BOTTOM
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas v1.0"),
        backgroundColor: Primary.Background,
        centerTitle: true,
      ),
      backgroundColor: Secondary.Background,
      body: Column(
        children: [
          // form para filtrar tarefas
          Visibility(
            visible: _filterForm,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 1, 10, 0),
              child: Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ConstruirTexto("Filtrar Tarefas", size: 20.0, bold: true)
                    ),
                    ConstruirCampo(_filtroController, "Filtro..."),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: VerticalDivider()),
                        ConstruirTexto("Modo de Exibição:", bold: true),
                        DropdownButton(
                          items: [
                            DropdownMenuItem(value: 0, child: ConstruirTexto("Todos")),
                            DropdownMenuItem(value: 1, child: ConstruirTexto("Somente Completas")),
                            DropdownMenuItem(value: 2, child: ConstruirTexto("Somente Incompletas"))
                          ],
                          onChanged: ((int? obj) => FiltrarTarefas(obj!)),
                          value: _modifier
                        )
                      ],
                    )
                  ]
                )
              )
            )
          ),
          // form para adicionar tarefas
          Visibility(
            visible: _addForm,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 1, 10, 0),
              child: Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Adicionar Tarefa", style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)
                      )
                    ),
                    ConstruirCampo(_tituloController, "Título..."),
                    ConstruirCampo(_subtituloController, "Subtítulo...")
                  ]
                )
              )
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
            height: 70.0,
            child: Row(
              children: [
                const Spacer(flex: 1),
                ConstruirBotao(Icons.add, _addForm, AdicionarTarefa),
                VerticalDivider(width: 10.0, thickness: 2, color: Secondary.Foreground),
                ConstruirBotao(Icons.search, _filterForm, FiltrarTarefas)
              ]
            )
          ), 
          Expanded(child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: _tarefas.length,
            itemBuilder: ConstruirItem,
          ))
        ],
      ),
    );
  }

  Widget ConstruirTexto(String text, {double size = 14.0, bool bold = false})
  { 
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(text, style: TextStyle(fontSize: size, fontWeight: bold ? FontWeight.bold : FontWeight.normal)
    ));
  }

  TextField ConstruirCampo(TextEditingController controller, String hint)
  {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black)
      )
    );
  }

  Widget ConstruirBotao(conteudo, bool state, metodo)
  {
    return RaisedButton(
      onPressed: (() {
        if (!state) { 
          AlternarEstados(); 
          if (_tarefasBackup.isNotEmpty) _tarefas = _tarefasBackup;
        }
        else { metodo(); }
      }),
      color: state ? Button.Selected : Button.Unselected,
      textColor: Primary.Foreground,
      child: conteudo is String ? ConstruirTexto(conteudo, bold: true) : Icon(conteudo),
      padding: const EdgeInsets.all(20),
    );
  }

  Widget ConstruirItem(context, index)
  {
    var item = _tarefas[index];
    var title = item.Title;
    var subtitle = item.Subtitle;
    var state = item.State;

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()), 
      background: Container(
        color: Primary.Background,
        child: const Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: state,
        secondary: CircleAvatar(child: Icon(state ? Icons.check : Icons.error)),
        onChanged: (newState) 
        { 
          setState(() 
          { 
            item.State = newState!; 
            FileService.SalvarDados(_tarefas);  
          }); 
        },
      ),
      onDismissed: (direction) 
      {
        setState(() {
          _tarefaRemovida = _tarefas.elementAt(index);
          _tarefaPosicao = index;
          _tarefas.removeAt(index);
          FileService.SalvarDados(_tarefas);
          
          final snack = SnackBar(
            content: Text("Tarefa '${_tarefaRemovida.Title}' removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _tarefas.insert(_tarefaPosicao, _tarefaRemovida);
                  FileService.SalvarDados(_tarefas);
                });
              },
            ),
          );

          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
    );
  }
}