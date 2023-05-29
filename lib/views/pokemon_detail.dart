// Importar el paquete de flutter que contiene los widgets básicos
import 'package:flutter/material.dart';
// Importar el modelo de pokémon que se usa como argumento
import 'package:pokedex/models/pokemon.dart';
// Importar el archivo donde definiste la función getColorByType
import '../../utils/colors_type_utils.dart';
// Importar el archivo evolutions_widget.dart
import './widgets/evolutions_widget.dart';
// Importar el paquete de provider que permite acceder a los datos del pokémon desde cualquier widget descendiente
import 'package:provider/provider.dart';

// Crear una clase que represente la pantalla de detalle de un pokémon
class PokemonDetail extends StatelessWidget {
  // El atributo que almacena el pokémon que se quiere mostrar
  final Pokemon pokemon;

  // El constructor de la clase que recibe el pokémon como argumento
  const PokemonDetail(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    // Envolver el widget Scaffold con un widget de tipo ChangeNotifierProvider que provee el pokémon como un modelo de datos observable
    return ChangeNotifierProvider<Pokemon>(
      create: (context) => pokemon,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pokemon.name),
        ),
        body: SingleChildScrollView(
          // Usar un widget de tipo SingleChildScrollView para permitir el desplazamiento
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Usar un widget de tipo Stack para colocar la imagen sobre un fondo circular
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Crear un widget de tipo Container con forma circular y color según el tipo del pokémon
                    Container(
                      width: 300.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getColorByType(pokemon.type).withOpacity(0.2),
                      ),
                    ),
                    // Mostrar la imagen del pokémon usando Image.network
                    Image.network(
                      pokemon.image,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                // Mostrar el nombre del pokémon usando Text
                Text(
                  pokemon.name,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: getColorByType(pokemon.type),
                  ),
                ),
                // Mostrar el tipo del pokémon usando Text
                Text(
                  pokemon.type,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color: getColorByType(pokemon.type),
                  ),
                ),
                // Agregar un widget de tipo EvolutionsWidget al final de la columna que muestra los datos del pokémon, pasándole el pokémon como argumento
                EvolutionsWidget(pokemon: pokemon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
