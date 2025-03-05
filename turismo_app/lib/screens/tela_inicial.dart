import 'package:flutter/material.dart';
import '../widgets/dropdown_perfil.dart';
import 'tela_sugestoes.dart';
import 'tela_inicial.dart';

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
        title: Text('TurismoApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _localizacaoController,
                        decoration: InputDecoration(
                          labelText: 'Localização',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _tempoEstadaController,
                        decoration: InputDecoration(
                          labelText: 'Tempo de Estada (dias)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      DropdownPerfil(
                        perfilViagem: _perfilViagem,
                        onChanged: (newValue) {
                          setState(() {
                            _perfilViagem = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: _mostrarSugestoes,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black45,
                ),
                child: Text(
                  'Mostrar Sugestões',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
