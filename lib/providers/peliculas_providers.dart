import 'dart:async';
import 'dart:convert';

import 'package:pelisapp/models/actores_model.dart';
import 'package:pelisapp/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '8e6bf21cb7b8d91e2e387ec0794a3614';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List();


  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  Function (List<Pelicula>)get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void _disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apikey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {


    if(_cargando) return  [];
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(
        _url, "3/movie/popular", {
          'api_key': _apikey, 
          'language': _language,
          'page': _popularesPage.toString()
          });

    final respuesta = await _procesarRespuesta(url);
    _populares.addAll(respuesta);

    popularesSink(_populares);

    _cargando = false;
    return respuesta;
  }

  Future <List<Actor>>getCast(String peliId)async{

    final url = Uri.https(_url, '/3/movie/$peliId/credits',{
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData["cast"]);

    return cast.actores;

  }



}
