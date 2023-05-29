import 'package:flutter/material.dart';
import 'package:pokedex/views/home_view.dart';
import 'package:pokedex/views/pokemon_list.dart';

void main() {
  runApp(const Pokedex());
}
class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
