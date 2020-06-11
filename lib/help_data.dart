import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

class HttpData {
  final String urlSearchBase =
'https://api.themoviedb.org/3/search/movie?api_key=356d29e4e07703aae8b26eec9ae53a8e&query=';
  final String urlKey = '356d29e4e07703aae8b26eec9ae53a8e';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<List> findMovie(String title) async {
    final String findmovie = urlSearchBase + title;
    http.Response query = await http.get(findmovie);
    if(query.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(query.body);
    final queryMovie = jsonResponse['query'];
    List movies = queryMovie.map((i) => Movie.fromJson(i)).toList();
    return movies;
  }
  else{
    return null;
  }
  }

  Future<List> getMovie() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response getdata = await http.get(upcoming);

    if (getdata.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(getdata.body);
      final moviesMap = jsonResponse['getdata'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
