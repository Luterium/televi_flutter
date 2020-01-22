import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:televi_flutter/data/repository/MoviesRepository.dart';
import './bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  MoviesBloc({this.movieRepository});
  @override
  MoviesState get initialState => MoviesLoading();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if(event is GetMovies) {
      yield MoviesLoading();
      try {
        final movieList = await movieRepository.getMovies();
        yield MoviesLoaded(movieList: movieList);
      } catch (e) {
        yield MoviesLoadingError();
        throw Exception('Request Error');
      }
    }
    else if(event is GetDetailedMovie) {
      yield MovieLoading();
      try {
        final movie = await movieRepository.getDetailedMovie(event.movieID);
        yield MovieLoaded(movie: movie);
      } catch (e) {
        yield MovieLoadingError();
        throw Exception('Request Error');
      }
    }
  }
}
