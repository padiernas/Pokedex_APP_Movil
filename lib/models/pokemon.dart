import 'dart:convert';
// ignore: library_prefixes
import 'package:http/http.dart' as httpPackage;
// Importar el paquete de flutter que contiene la clase ChangeNotifier
import 'package:flutter/foundation.dart';

// Definir la clase Pokemon con un mixin de ChangeNotifier

class Pokemon with ChangeNotifier {
  // Los atributos de la clase
  String name;
  String url;
  int id;
  String type; // se agrega el atributo type
  String image;
  List<Pokemon>? evolutions; // se cambia el atributo evolution a una lista de Pokemon

  // El constructor de la clase
  Pokemon({
    required this.name,
    required this.url,
    required this.id,
    required this.type,
    required this.image,
    required this.evolutions,
  }); // se cambia el parámetro evolution a una lista de Pokemon

  static get http => null;

  static get pokemonEvolutions => null;

  // El método estático para crear una instancia desde un mapa
  static Future<Pokemon> fromJson(Map<String, dynamic> json) async {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      id: _getIdFromUrl(json['url']),
      type: await _getTypeFromUrl(
          json['url']), // se asigna el valor del tipo desde la url
      image: await _getImageFromUrl(
          json['url']), // se asigna el valor de la imagen desde la url
      evolutions: await _getEvolutionsFromUrl(
          json['url']), // se asigna el valor de las evoluciones desde la url
    );
  }

  // Un método auxiliar para obtener el id desde la url
  static int _getIdFromUrl(String url) {
    // Extraer el último segmento de la url
    String lastSegment = url.split('/').last;

    // Intentar convertirlo a un número entero
    try {
      int id = int.parse(lastSegment);

      // Devolver el id
      return id;
    } catch (e) {
      // Capturar la excepción si la cadena no es válida para un número
      // ignore: avoid_print
      print('La cadena no es válida para un número: $e');

      // Devolver un valor por defecto o lanzar otra excepción
      return 0; // o throw Exception('No se pudo obtener el id desde la url');
    }
  }

  // Un método auxiliar para obtener el tipo desde la url
  static Future<String> _getTypeFromUrl(String url) async {
    // Hacer una petición al api para obtener los datos del pokémon
    httpPackage.Response response = await httpPackage.get(Uri.parse(url));

    // Verificar si la respuesta es exitosa
    if (response.statusCode == 200) {
      // Obtener los datos en formato JSON
      var data = jsonDecode(response.body);

      // Obtener el primer tipo del pokémon (se asume que tiene al menos uno)
      String type = data['types'][0]['type']['name'];

      // Devolver el tipo
      return type;
    } else {
      // Lanzar una excepción si hay algún error
      throw Exception('Error al obtener el tipo del pokémon');
    }
  }

  // Un método auxiliar para obtener la imagen desde la url
  static Future<String> _getImageFromUrl(String url) async {
    // Hacer una petición al api para obtener los datos del pokémon
    httpPackage.Response response = await httpPackage.get(Uri.parse(url));

    // Verificar si la respuesta es exitosa
    if (response.statusCode == 200) {
      // Obtener los datos en formato JSON
      var data = jsonDecode(response.body);

      // Obtener la url de la imagen del pokémon (se asume que tiene al menos una)
      String image = data['sprites']['front_default'];

      // Devolver la url de la imagen
      return image;
    } else {
      // Lanzar una excepción si hay algún error
      throw Exception('Error al obtener la imagen del pokémon');
    }
  }

  // Un método auxiliar para obtener las evoluciones desde la url
  static Future<List<Pokemon>> _getEvolutionsFromUrl(String url) async {
    // Hacer una petición al api para obtener los datos del pokémon
    httpPackage.Response response = await httpPackage.get(Uri.parse(url));

    // Verificar si la respuesta es exitosa
    if (response.statusCode == 200) {
      // Obtener los datos en formato JSON
      var data = jsonDecode(response.body);

      // Obtener la lista de evoluciones del pokémon (se asume que tiene al menos una)
      List<dynamic>? evolutions = data['evolves_to'] as List<dynamic>?;

      // Crear una lista vacía de Pokemon para almacenar las evoluciones
      List<Pokemon> pokemonEvolutions = [];

      // Iterar sobre cada evolución y crear un objeto Pokemon con sus datos
      for (var evolution in evolutions ?? []) {
        // se usa el operador ?? para evitar iterar sobre una lista nula

        String name = evolution['species']['name'];
        String url = evolution['species']['url'];
        int id = _getIdFromUrl(url);
        String type = await _getTypeFromUrl(url);
        String image = await _getImageFromUrl(url);
        List<Pokemon> evolutions = await _getEvolutionsFromUrl(url);

        Pokemon pokemonEvolution = Pokemon(
          name: name,
          url: url,
          id: id,
          type: type,
          image: image,
          evolutions: evolutions,
        );

        pokemonEvolutions.add(pokemonEvolution);
      }

      // Devolver la lista de evoluciones como Pokemon
      if (pokemonEvolutions.isEmpty) {
        return []; // o throw Exception('No se encontraron evoluciones');
      } else {
        return pokemonEvolutions;
      }
    } else {
      // Lanzar una excepción si hay algún error
      throw Exception('Error al obtener las evoluciones del pokémon');
    }
  }
}
