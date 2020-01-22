import 'package:http/http.dart' as http;
import 'package:televi_flutter/data/remote_data_source/MovieRemoteDataSource.dart';

class MovieRepository{
  final http.Client client;
  MovieRDS remoteDataSource;

  MovieRepository({this.client}) {
    remoteDataSource = MovieRDS(client: client);
  }

  getMovies() => remoteDataSource.getMovies();
  getDetailedMovie(int movieID) => remoteDataSource.getDetailedMovie(movieID);
}