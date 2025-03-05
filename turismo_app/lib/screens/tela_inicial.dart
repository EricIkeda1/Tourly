import 'package:flutter/material.dart';
import '../widgets/dropdown_perfil.dart';
import 'tela_sugestoes.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _localizacaoController = TextEditingController();
  final _tempoEstadaController = TextEditingController();
  String _perfilViagem = 'Aventura';

  void _mostrarSugestoes() {
    final localizacao = _localizacaoController.text;
    final tempoEstada = _tempoEstadaController.text;

    if (localizacao.isEmpty || tempoEstada.isEmpty) {
      return;
    }

    String sugestao = 'Passeios sugeridos para $localizacao por $tempoEstada dias:';

    if (_perfilViagem == 'Aventura') {
      sugestao += '\n- Trilhas e atividades ao ar livre.';
    } else if (_perfilViagem == 'Cultural') {
      sugestao += '\n- Museus e pontos históricos.';
    } else {
      sugestao += '\n- Passeios e atividades relaxantes.';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaSugestoes(sugestao: sugestao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TurismoApp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _localizacaoController,
              decoration: InputDecoration(labelText: 'Localização'),
            ),
            TextField(
              controller: _tempoEstadaController,
              decoration: InputDecoration(labelText: 'Tempo de Estada (dias)'),
              keyboardType: TextInputType.number,
            ),
            DropdownPerfil(
              perfilViagem: _perfilViagem,
              onChanged: (newValue) {
                setState(() {
                  _perfilViagem = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _mostrarSugestoes,
              child: Text('Mostrar Sugestões'),
            ),
          ],
        ),
      ),
    );
  }
}
