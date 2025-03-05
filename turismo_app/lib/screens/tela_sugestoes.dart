import 'package:flutter/material.dart';

class TelaSugestoes extends StatelessWidget {
  final String sugestao;

  TelaSugestoes({required this.sugestao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugestões de Passeios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sugestao,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
