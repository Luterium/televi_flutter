import 'package:meta/meta.dart';
import 'package:televi_flutter/data/models/DetailedMovie.dart';

@immutable
abstract class DetailedMovieState {
  const DetailedMovieState();
}
  
class InitialDetailedMovieState extends DetailedMovieState {}

class MovieLoading extends DetailedMovieState {
  const MovieLoading();
}

class MovieLoaded extends DetailedMovieState {
  final DetailedMovie movie;
  const MovieLoaded({this.movie});
}

class MovieLoadingError extends DetailedMovieState {
  const MovieLoadingError();
}
