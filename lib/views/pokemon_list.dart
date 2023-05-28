import 'package:flutter/material.dart';
import 'package:pokedex/controllers/api_controller.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/views/pokemon_detail.dart';

class PokemonList extends StatelessWidget {
  // El controlador que se encarga de obtener los datos del api
  final ApiController _controller = ApiController();

  PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        // El futuro que se espera resolver
        future: _controller.fetchPokemons(),
        // El constructor que se ejecuta según el estado del futuro
        builder: (context, snapshot) {
          // Si el futuro está en espera, mostrar un indicador de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Si el futuro tiene un error, mostrar un mensaje de error
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // Si el futuro tiene datos, mostrar la lista de pokémon
          if (snapshot.hasData) {
            // Obtener la lista de pokémon desde los datos del snapshot
            List<Pokemon> pokemons = snapshot.data!;

            // Crear un widget de tipo ListView.builder para mostrar la lista
            return ListView.builder(
              // El número de elementos de la lista es el mismo que el de pokémon
              itemCount: pokemons.length,
              // El constructor que se ejecuta para cada elemento de la lista
              itemBuilder: (context, index) {
                // Obtener el pokémon correspondiente al índice
                Pokemon pokemon = pokemons[index];

                // Crear un widget de tipo Card para mostrar el pokémon
                return Card(
                  child: ListTile(
                    // El título es el nombre del pokémon
                    title: Text(pokemon.name),
                    // La imagen es una redondeada que usa la url del pokémon
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pokemon.url),
                    ),
                    // El subtítulo es el tipo del pokémon (se asume que tiene uno solo)
                    subtitle: Text(pokemon.type),
                    // Al tocar el elemento, se navega a otra pantalla (se asume que existe)
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetail(pokemon),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          // Si el futuro no tiene datos, mostrar un mensaje vacío
          return const Center(
            child: Text('No hay datos'),
          );
        },
      ),
    );
  }
}
