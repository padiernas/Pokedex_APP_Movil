import 'dart:convert';
// ignore: library_prefixes
import 'package:http/http.dart' as httpPackage;

class Pokemon {
  // Los atributos de la clase
  String name;
  String url;
  int id;
  String type; // se agrega el atributo type

  // El constructor de la clase
  Pokemon({ required this.name, required this.url, required this.id, required this.type});
  
  static get http => null;

  // El método estático para crear una instancia desde un mapa
  static Future<Pokemon> fromJson(Map<String, dynamic> json) async {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      id: _getIdFromUrl(json['url']),
      type:await _getTypeFromUrl(json['url']), // se asigna el valor del tipo desde la url
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
}
