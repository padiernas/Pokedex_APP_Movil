// Importar los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
// Importar el archivo donde definiste la función getColorByType
import '../../utils/colors_type_utils.dart';
import '../../utils/icons_type_utils.dart';
import '../pokemon_detail.dart';

// Definir una clase que extienda de StatelessWidget y que tenga como atributo un Pokemon
class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  // El constructor de la clase que recibe el pokémon como argumento
  const PokemonCard(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    // Envolver el widget Card con un widget GestureDetector para detectar el gesto de tocar la card
    return GestureDetector(
      // Dentro del argumento onTap del widget GestureDetector, usar el método Navigator.push para navegar a la pantalla de pokemon_detail.dart, pasándole el pokémon como argumento
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon),
          ),
        );
      },
      // Devolver el widget Card que quieres usar
      child: Card(
        child: Column(
          children: [
            // Mostrar la imagen del pokémon usando un Container con un tamaño fijo y un borde redondeado
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(pokemon.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Mostrar el nombre del pokémon usando Text con un estilo grande y en negrita
            Text(
              pokemon.name,
              style:
                  const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            // Mostrar el tipo del pokémon usando un Chip con un color de fondo según el tipo y un estilo mediano y en cursiva
            Icon(
              // Mostramos el icono del tipo del pokemon usando el mapa que definimos en el documento typeIcons
              typeIcons[pokemon.type],
              color: getColorByType(pokemon
                  .type), // Usamos la función que definimos antes para obtener el color según el tipo
            ),
          ],
        ),
      ),
    );
  }
}
