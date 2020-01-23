import 'package:meta/meta.dart';
import 'package:televi_flutter/data/models/Movie.dart';

@immutable
abstract class MoviesState {
  const MoviesState();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  final List<Movie> movieList;
  const MoviesLoaded({this.movieList});
}

class MoviesLoadingError extends MoviesState {
  const MoviesLoadingError();
}
