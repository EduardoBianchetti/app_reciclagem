import 'package:flutter/material.dart';
import '../model/lixo.dart';

class LixoEditPage extends StatefulWidget {
  const LixoEditPage({super.key, this.selecionado});

  final Lixo? selecionado;

  @override
  State<LixoEditPage> createState() => _LixoEditPageState();
}

class _LixoEditPageState extends State<LixoEditPage> {
  final _descricaoCon = TextEditingController();
  final _tipoCon = TextEditingController();
  final _pesoCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descricaoCon.text = widget.selecionado!.descricao!;
    _tipoCon.text = widget.selecionado!.tipo!;
    _pesoCon.text = widget.selecionado!.peso!;
  }

  void salvar() {
    widget.selecionado!.descricao = _descricaoCon.text;
    widget.selecionado!.tipo = _tipoCon.text;
    widget.selecionado!.peso = _pesoCon.text;
    Navigator.pop(context, 'Salvar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de Lixo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _descricaoCon,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição',
                ),
              ),
              TextFormField(
                controller: _tipoCon,
                keyboardType: TextInputType.text,
                maxLength: 20,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tipo de Lixo',
                ),
              ),
              TextFormField(
                controller: _pesoCon,
                keyboardType: TextInputType.text,
                maxLength: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Peso em KG',
                ),
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: ElevatedButton(
                        child: const Text('Salvar'),
                        onPressed: () {
                          salvar();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: ElevatedButton(
                        child: const Text('Excluir'),
                        onPressed: () {
                          Navigator.pop(context, 'Excluir');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: ElevatedButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.pop(context, 'Cancelar');
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
