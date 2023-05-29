// Importar los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
// Importar el archivo donde pusiste el widget Card
import 'card_widget.dart';

// Definir una clase que extienda de StatelessWidget y que tenga como atributo una lista de pokémon
class GridWidget extends StatelessWidget {
  final List<Pokemon> pokemons;

  // El constructor de la clase que recibe la lista de pokémon como argumento
  const GridWidget(this.pokemons, {super.key});

  @override
  Widget build(BuildContext context) {
    // Devolver el widget GridView.count que ya habías creado antes, pasándole la lista de pokémon como argumento
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 10.0,
      // Aumentar el valor del argumento childAspectRatio para tener un contenido más largo
      childAspectRatio: 0.8,
      children: pokemons.map((pokemon) {
        // Crear una instancia de la clase PokemonCard y pasarle el pokémon como argumento
        return PokemonCard(pokemon);
        // Usar un widget ClipRRect para recortar el widget Card según el radio de la esquina
      }).toList(),
    );
  }
}

