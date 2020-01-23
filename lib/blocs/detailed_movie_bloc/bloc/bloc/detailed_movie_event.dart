import 'package:meta/meta.dart';

@immutable
abstract class DetailedMovieEvent {
  const DetailedMovieEvent();
}

class GetDetailedMovie extends DetailedMovieEvent {
  final int movieID;

  const GetDetailedMovie({@required this.movieID});
}
