import 'package:flutter/material.dart';
import 'package:pelisapp/models/pelicula_model.dart';
import 'package:pelisapp/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  final peliculas = ['Ironman','Spiderman', 'Aquaman', 'Batman', 'Superman', 'Cocoman','Shazam'];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];
  final peliculasProvider = new PeliculasProvider();
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
        color: Colors.red,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot){
        if(snapshot.hasData){

          final pelis = snapshot.data;
          return ListView(
            children: pelis.map((p) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(p.getPosterImg(),
                  ),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: (){
                  close(context,null);
                  p.uniqueId = '';
                  Navigator.of(context).pushNamed('detalle', arguments: p);
                },
              );
            }
          ).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }


      },
    );
    
  }
}
