import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final peliculas = ['Ironman','Spiderman', 'Aquaman', 'Batman', 'Superman', 'Cocoman','Shazam'];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  String seleccion;

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de el appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono izquierda appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //RESULTADOS QUE VAMOS A MOSTRAR

    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    // Son las sugerencias que aparecen cuando escribres
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          subtitle: Text("ESE"),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  }
}
