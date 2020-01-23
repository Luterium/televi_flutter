import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:televi_flutter/data/repository/MoviesRepository.dart';
import './bloc.dart';

class DetailedMovieBloc extends Bloc<DetailedMovieEvent, DetailedMovieState> {
  final MovieRepository movieRepository;

  DetailedMovieBloc({this.movieRepository});

  @override
  DetailedMovieState get initialState => InitialDetailedMovieState();

  @override
  Stream<DetailedMovieState> mapEventToState(
    DetailedMovieEvent event,
  ) async* {
    if(event is GetDetailedMovie) {
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
