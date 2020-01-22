import 'package:http/http.dart' as http;
import 'package:televi_flutter/data/models/DetailedMovie.dart';
import 'package:televi_flutter/data/models/Movie.dart';
import 'dart:convert';

class MovieRDS{
  final http.Client client;
  final String baseURL = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies";

  MovieRDS({this.client});

  Future<List<Movie>> getMovies() async {
    final response = await client.get(baseURL);

    if(response.statusCode == 200) {
      var movieList = new List<Movie>();

      json.decode(response.body).toList().forEach((movie) {
        movieList.add(Movie.fromJson(movie));
      });

      return movieList;
    } else {
      print("Request Error: ${response.statusCode}");
      throw Exception('Request Error: ${response.statusCode}');
    }
  }

  Future<DetailedMovie> getDetailedMovie(int movieID) async {
    final response = await client.get(baseURL + "/$movieID");

    if(response.statusCode == 200) {
      return DetailedMovie.fromJson(json.decode(response.body));
    } else {
      print("Request Error: ${response.statusCode}");
      throw Exception('Request Error: ${response.statusCode}');
    }
  }
}