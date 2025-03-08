import 'package:flutter/material.dart';
import 'tela_sugestoes.dart';
import 'package:turismo_app/models/sugestao.dart';
import 'package:turismo_app/widgets/dropdown_perfil.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _localizacaoController = TextEditingController();
  final _tempoEstadaController = TextEditingController();
  String _perfilViagem = 'Aventura';
  bool _isLoading = false;

  void _mostrarSugestoes() async {
    final localizacao = _localizacaoController.text;
    final tempoEstada = _tempoEstadaController.text;

    if (localizacao.isEmpty || tempoEstada.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Sugestao sugestao = await Sugestao.obterSugestao(
        localizacao,
        tempoEstada,
        _perfilViagem,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaSugestoes(sugestao: sugestao.descricao),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao obter sugestões!')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                onPressed: _isLoading ? null : _mostrarSugestoes,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black45,
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
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
