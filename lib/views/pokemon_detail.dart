// Importar el paquete de flutter que contiene los widgets básicos
import 'package:flutter/material.dart';

// Importar el modelo de pokémon que se usa como argumento
import 'package:pokedex/models/pokemon.dart';

// Crear una clase que represente la pantalla de detalle de un pokémon
class PokemonDetail extends StatelessWidget {
  // El atributo que almacena el pokémon que se quiere mostrar
  final Pokemon pokemon;

  // El constructor de la clase que recibe el pokémon como argumento
  const PokemonDetail(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    // Crear un widget de tipo Scaffold para mostrar la pantalla
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: const Center(
        child: Text('Aquí se mostrarán los detalles del pokémon'),
      ),
    );
  }
}
