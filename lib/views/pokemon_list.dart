// En el archivo pokemonlist.dart

// Importar los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:pokedex/controllers/api_controller.dart';
import 'package:pokedex/models/pokemon.dart';
// Importar el archivo donde pusiste el widget Grid
import 'widgets/grid_widget.dart';

class PokemonList extends StatelessWidget {
  // El controlador que se encarga de obtener los datos del api
  final ApiController _controller = ApiController();

  PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usar el widget Scaffold para envolver el widget AppBar
      appBar: AppBar(
        // Quitar el color de fondo de la barra usando la propiedad backgroundColor y asignándole Colors.transparent
        backgroundColor: Colors.transparent,
        // Quitar la sombra de la barra usando la propiedad elevation y asignándole 0.0
        elevation: 0.0,
        // Aumentar el tamaño del texto del título usando la propiedad style del widget Text y asignándole un TextStyle con un fontSize mayor
        title: const Text('Pokedex', style: TextStyle(fontSize: 32.0)),
        // Agregar un menú desplegable al lado derecho de la barra usando la propiedad actions del widget AppBar y asignándole una lista con un widget PopupMenuButton
        actions: [
          PopupMenuButton(
            // Definir los ítems del menú usando la propiedad itemBuilder y asignándole una función que devuelva una lista de PopupMenuItem con los textos y valores que quieras
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Ordenar por nombre'),
              ),
              const PopupMenuItem(
                value: 'number',
                child: Text('Ordenar por número'),
              ),
              const PopupMenuItem(
                value: 'type',
                child: Text('Ordenar por tipo'),
              ),
            ],
            // Definir la acción que se ejecuta al seleccionar un ítem del menú usando la propiedad onSelected y asignándole una función que reciba el valor del ítem seleccionado
            onSelected: (value) {
              // Aquí puedes poner la lógica para ordenar la lista de pokémon según el valor seleccionado
            },
          ),
        ],
        // Asignar un IconThemeData a la propiedad iconTheme para cambiar el color de los iconos de la barra
        iconTheme: const IconThemeData(
          color: Colors.red, // El color que quieras para los iconos
        ),
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

            // Usar el widget GridWidget en lugar del widget GridView.count, pasándole la lista de pokémon como argumento
            return GridWidget(pokemons);
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
