import 'dart:convert';
import 'package:http/http.dart' as http;

class Sugestao {
  final String localizacao;
  final String tempoEstada;
  final String perfilViagem;
  final String descricao;

  Sugestao({
    required this.localizacao,
    required this.tempoEstada,
    required this.perfilViagem,
    required this.descricao,
  });

  static Future<Sugestao> obterSugestao(
      String localizacao, String tempoEstada, String perfilViagem) async {
    final apiKey = ''; 

    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$localizacao&appid=$apiKey&units=metric&lang=pt';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String clima = data['weather'][0]['description'];

        String sugestao = 'O clima em $localizacao é $clima.';

        if (perfilViagem == 'Aventura') {
          sugestao += ' Aventure-se em trilhas, escaladas e atividades ao ar livre!';
        } else if (perfilViagem == 'Cultural') {
          sugestao += ' Explore museus, galerias e pontos históricos!';
        } else if (perfilViagem == 'Relaxante') {
          sugestao += ' Relaxe com atividades tranquilas, spas e descanso!';
        } else {
          sugestao += ' Aproveite o que há de melhor em sua viagem!';
        }

        return Sugestao(
          localizacao: localizacao,
          tempoEstada: tempoEstada,
          perfilViagem: perfilViagem,
          descricao: sugestao,
        );
      } else {
        throw Exception('Falha ao obter dados da API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao se conectar à API: $e');
    }
  }
}
