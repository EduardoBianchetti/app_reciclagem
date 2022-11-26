import 'package:app_reciclagem/model/lixo.dart';
import 'package:app_reciclagem/pages/lixo_edit_page.dart';
import 'package:app_reciclagem/sqlite/lixo_helper.dart';
import 'package:app_reciclagem/util/dialogos.dart';
import 'package:flutter/material.dart';

class LixoListPage extends StatefulWidget {
  const LixoListPage({super.key, this.title});
  final String? title;

  @override
  State<LixoListPage> createState() => _LixoListPageState();
}

class _LixoListPageState extends State<LixoListPage> {
  final lixoDb = LixoHelper();
  List<Lixo> lixos = List.empty();
  Lixo? selecionado;

  void _getAllLixos() {
    lixoDb.obterTodos().then((list) {
      setState(() {
        lixos = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllLixos();
  }

  selecionar(int selecao) {
    selecionado = lixos[selecao];
    _showLixoPage();
  }

  void _incluir() {
    selecionado = Lixo();
    _showLixoPage();
  }

  void _showLixoPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LixoEditPage(
          selecionado: selecionado,
        ),
      ),
    );
    if (result != null) {
      if (result == 'Salvar') {
        if (selecionado!.id == null) {
          lixoDb.inserir(selecionado!).then((_) {
            _getAllLixos();
            Dialogos.showAlertDialog(context, 'Dados inseridos com sucesso!');
          });
        } else {
          lixoDb.alterar(selecionado!).then((_) {
            _getAllLixos();
            Dialogos.showAlertDialog(context, 'Dados alterados com sucesso!');
          });
        }
      } else if (result == 'Excluir') {
        lixoDb.excluir(selecionado!.id!).then((_) {
          _getAllLixos();
          Dialogos.showAlertDialog(context, 'Dados excluídos com sucesso!');
        });
      } else if (result == 'Cancelar') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de Lixo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(15.0),
            itemCount: lixos.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(
                  children: <Widget>[
                    Text('${lixos[index].id}'),
                    const SizedBox(width: 20),
                    Text(lixos[index].descricao!),
                    const SizedBox(width: 20),
                    Text(lixos[index].tipo!),
                    const SizedBox(width: 20),
                    Text(lixos[index].peso!),
                  ],
                ),
                onTap: () => selecionar(index),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incluir,
        tooltip: 'incluir',
        child: const Icon(Icons.add),
      ),
    );
  }
}
