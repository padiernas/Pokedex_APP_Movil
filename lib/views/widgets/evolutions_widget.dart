import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import '../../utils/colors_type_utils.dart';
import '../pokemon_detail.dart'; // Importar el archivo donde definiste la función getColorByType

class EvolutionsWidget extends StatelessWidget {
  final Pokemon pokemon;
  const EvolutionsWidget({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener la lista de evoluciones del pokemon desde el provider
    final evolutionsList = Provider.of<Pokemon>(context).evolutions;

    // Crear un widget ListView con un constructor builder
    return ListView.builder(
      // Pasar el número de elementos de la lista
      itemCount: evolutionsList?.length,
      // Pasar una función que devuelve el widget para cada elemento
      itemBuilder: (context, index) {
        // Obtener la evolución correspondiente al índice
        final evolution = evolutionsList![index];
        // Devolver un widget InkWell envolviendo un Card con un ListTile que muestra la imagen y el nombre de la evolución
        return InkWell(
          onTap: () {
            // Navegar a la pantalla de detalle de la evolución usando Navigator.push
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetail(evolution),
              ),
            );
          },
          child: Card(
            child: ListTile(
              // Usar un widget CircleAvatar para mostrar la imagen de la evolución con forma circular y borde del color del tipo
              leading: CircleAvatar(
                backgroundImage: NetworkImage(evolution.image),
                backgroundColor: Colors.white,
                radius: 30.0,
                foregroundColor: getColorByType(evolution.type),
              ),
              // Usar el nombre de la evolución como título del ListTile
              title: Text(evolution.name),
            ),
          ),
        );
        // Usar un widget Divider para separar los elementos de la lista con una línea horizontal
        // return const Divider();
      },
    );
  }
}
