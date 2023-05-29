// Importar el paquete de font awesome que contiene los iconos
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Crear un mapa que asocie cada tipo de pokemon con su respectivo icono
final Map<String, IconData> typeIcons = {
  'normal': FontAwesomeIcons.circle,
  'fire': FontAwesomeIcons.fire,
  'water': FontAwesomeIcons.tint,
  'grass': FontAwesomeIcons.leaf,
  'electric': FontAwesomeIcons.bolt,
  'psychic': FontAwesomeIcons.brain,
  'flying': FontAwesomeIcons.featherAlt,
  'poison': FontAwesomeIcons.skullCrossbones,
  'ground': FontAwesomeIcons.mountain,
  'rock': FontAwesomeIcons.gem,
  'bug': FontAwesomeIcons.bug,
  'ghost': FontAwesomeIcons.ghost,
  'steel': FontAwesomeIcons.cog,
  'dragon': FontAwesomeIcons.dragon,
  'dark': FontAwesomeIcons.moon,
  'fairy': FontAwesomeIcons.magic,
  'fighting': FontAwesomeIcons.fistRaised,
  'ice': FontAwesomeIcons.snowflake
};
