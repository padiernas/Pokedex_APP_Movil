import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class ApiController {
  // La url base del api de Pokeapi
  final String _baseUrl = 'https://pokeapi.co/api/v2/';

  // El método para obtener los pokémon
  Future<List<Pokemon>> fetchPokemons([int limit = 10]) async {
    // Construir la url con el parámetro opcional
    String url = '${_baseUrl}pokemon?limit=${limit}';

    // Hacer la petición GET al api
    http.Response response = await http.get(Uri.parse(url));

    // Verificar si la respuesta es exitosa
    if (response.statusCode == 200) {
      // Obtener los datos en formato JSON
      var data = jsonDecode(response.body);

      // Convertir los datos en una lista de objetos Pokemon
List<Pokemon> pokemons = await Future.wait((data['results'] as List<dynamic>)
    .map<Future<Pokemon>>((dynamic item) async =>await Pokemon.fromJson(item)));

      // Devolver la lista de pokémon
return pokemons.toList();

    } else {
      // Lanzar una excepción si hay algún error
      throw Exception('Error al obtener los datos del api');
    }
  }
}