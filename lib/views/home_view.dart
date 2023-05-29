import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/views/widgets/box_type_widget.dart';

// Importar el widget PokemonList desde otro archivo
import 'package:pokedex/views/pokemon_list.dart';

class Home extends StatelessWidget {
  final Pokemon pokemon;

  Home(this.pokemon,{Key? key,}) : super(key: key);

  // Crear una lista vacía y privada de widgets para almacenar los recuadros
  final List<Widget> _typeCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Qué pokemon vas',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 8.0), // Este widget separa los textos
                  Text(
                    'a conocer el día de hoy?',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: GestureDetector(
              // Usar un widget GestureDetector para detectar el gesto de tocar la barra de búsqueda
              onTap: () {
                // Usar el método Navigator.push para navegar a la pantalla del widget PokemonList
                Navigator.push(
                  context, // El contexto del widget actual
                  MaterialPageRoute(
                    // El widget que crea la ruta a la que se quiere navegar
                    builder: (context) =>
                        PokemonList(), // El widget que se muestra en la nueva pantalla
                  ),
                );
              },
              child: TextField(
                // El widget hijo del GestureDetector
                decoration: InputDecoration(
                  hintText: 'Busca un pokemon',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: Colors.black87),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8.0),
                ),
                style:
                    const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
              // Usar un widget FutureBuilder para construir widgets a partir de un futuro
              FutureBuilder<List<Pokemon>>(
                // Usar la función getPokemonList como el futuro
                future: getPokemonList(),
                // Definir el widget que se muestra mientras se espera el resultado del futuro
                builder: (context, snapshot) {
                  // Verificar si el futuro tiene datos
                  if (snapshot.hasData) {
                    // Obtener la lista de pokémon como objetos Pokemon
                    List<Pokemon> pokemonList = snapshot.data!;
                    // Usar una expresión map para crear una lista de widgets a partir de la lista de pokémon
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 2.4,
                      children: pokemonList.map((pokemon) {
                        // Crear un widget TypeBox con el tipo del pokémon como parámetro
                        Widget typeBox = TypeBox(type: pokemon.type);
                        // Añadir el widget a la lista de recuadros
                        _typeCards.add(typeBox);
                        // Devolver el widget
                        return typeBox;
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    // Si el futuro tiene un error, mostrar un widget con el mensaje de error
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    // Si el futuro está en espera, mostrar un widget con un indicador de progreso circular
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Pokemon>> getPokemonList() async {
  // Hacer una petición al api para obtener una lista de pokémon
  http|.Response response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));

  // Verificar si la respuesta es exitosa
  if (response.statusCode == 200) {
    // Obtener los datos en formato JSON
    var data = http.jsonDecode(response.body);

    // Obtener la lista de pokémon como un mapa
    List<dynamic> pokemonMap = data['results'];

    // Crear una lista vacía de objetos Pokemon para almacenar los pokémon
    List<Pokemon> pokemonList = [];

    // Iterar sobre cada pokémon del mapa y crear un objeto Pokemon con sus datos
    for (var pokemon in pokemonMap) {
      // Obtener el nombre y la url del pokémon
      String name = pokemon['name'];
      String url = pokemon['url'];

      // Usar el método estático fromJson para crear un objeto Pokemon a partir del url
      Pokemon pokemonObject = await Pokemon.fromJson(url);

      // Añadir el objeto Pokemon a la lista de pokémon
      pokemonList.add(pokemonObject);
    }

    // Devolver la lista de pokémon como objetos Pokemon
    return pokemonList;
  } else {
    // Lanzar una excepción si hay algún error
    throw Exception('Error al obtener la lista de pokémon');
  }
}
