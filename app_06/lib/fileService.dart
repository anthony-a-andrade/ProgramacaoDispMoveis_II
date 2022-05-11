import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:app_06/tarefa.dart';

class FileService
{
  static Future<File> ObterArquivo() async
  {
    final directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}/data.json";
    var file = File(path);
    await file.create();
    return file;
  }

  static Future<String?> ObterDados() async
  {
    try
    {
      final _file = await ObterArquivo();
      return await _file.readAsString();
    }
    catch (e)
    {
      return null;
    }
  }

  static Future<File> SalvarDados(List<Tarefa> tarefas) async
  {
    String data = json.encode(tarefas);
    final _file = await ObterArquivo();
    return _file.writeAsString(data);
  }
}