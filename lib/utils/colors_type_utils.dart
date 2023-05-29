// Importar el paquete de flutter que contiene los colores
import 'package:flutter/material.dart';

// Definir una función que reciba el tipo del pokémon y devuelva un color según el tipo
Color getColorByType(String type) {
  // Usar una estructura switch-case para evaluar el tipo y asignar el color correspondiente
  switch (type) {
    case 'grass':
      return Colors.green;
    case 'fire':
      return Colors.red;
    case 'water':
      return Colors.blue;
    case 'electric':
      return Colors.yellow;
    case 'psychic':
      return Colors.pink;
    case 'normal':
      return Colors.brown;
    case 'flying':
      return Colors.cyan;
    case 'poison':
      return Colors.purple;
    case 'ground':
      return Colors.orange;
    case 'rock':
      return Colors.grey;
    case 'bug':
      return Colors.lime;
    case 'ghost':
      return Colors.indigo;
    case 'steel':
      return const Color(0xFFB8B8D0);
    case 'dragon':
      return Colors.teal;
    case 'dark':
      return Colors.black;
    case 'fairy':
      return const Color(0xFFEE99AC);
    case 'fighting':
      return const Color(0xFFC03028);
    case 'ice':
      return Colors.lightBlue;
    default:
      return Colors.white;
  }
}
