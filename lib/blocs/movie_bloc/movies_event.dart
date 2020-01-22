import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent {
  const MoviesEvent();
}

class GetMovies extends MoviesEvent {
  const GetMovies();
}

class GetDetailedMovie extends MoviesEvent {
  final int movieID;

  const GetDetailedMovie({@required this.movieID});
}
