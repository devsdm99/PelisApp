import 'package:flutter/material.dart';

import 'package:pelisapp/pages/home_page.dart';
import 'package:pelisapp/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}