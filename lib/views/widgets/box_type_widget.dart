// Definir un widget que reciba el tipo de pokemon como parámetro
import 'package:flutter/material.dart';
import 'package:pokedex/utils/icons_type_utils.dart';

import '../../utils/colors_type_utils.dart';

class TypeBox extends StatelessWidget {
  final String type;

  // El constructor del widget
  const TypeBox({Key? key, required this.type}) : super(key: key);

  // El método build que devuelve el widget
  @override
  Widget build(BuildContext context) {
    // Usar la función getColorByType para obtener el color según el tipo
    Color color = getColorByType(type);

    // Devolver un Container con un BoxDecoration y un Text
    return Container(
      // Quitar el padding
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        // Cambiar el widget Align por Row
        crossAxisAlignment: CrossAxisAlignment
            .center, // Usar la propiedad crossAxisAlignment para alinear los widgets verticalmente al centro
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Usar la propiedad mainAxisAlignment para alinear los widgets horizontalmente con espacio entre ellos
        children: [
          Padding(
            // Usar un widget Padding para darle espacio al texto
            padding:
                const EdgeInsets.fromLTRB(32, 8, 0, 8), // Ajustar el padding
            child: Text(
              // Usar un widget Text para mostrar el tipo
              type.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.fromLTRB(0, 8, 16, 0),
          child: Icon(
            // Usar un widget Icon para mostrar el icono
            // Mostramos el icono del tipo del pokemon usando el mapa que definimos en el documento typeIcons
            typeIcons[type],
            size:56, // Usar la propiedad size para darle un tamaño más grande al icono
            color:Colors.black38, // Usar la propiedad color para darle el mismo color que el recuadro
          ),
          )
        ],
      ),
    );
  }
}
