import 'package:flutter/material.dart';

class DropdownPerfil extends StatelessWidget {
  final String perfilViagem;
  final ValueChanged<String?> onChanged;

  DropdownPerfil({
    required this.perfilViagem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: perfilViagem,
      onChanged: onChanged,
      items: <String>['Aventura', 'Cultural', 'Relaxante']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
