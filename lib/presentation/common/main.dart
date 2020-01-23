import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';
import 'package:televi_flutter/blocs/movie_bloc/movies_bloc.dart';
import 'package:televi_flutter/presentation/scenes/movie/movie_list/MovieList.dart';
import 'package:televi_flutter/data/repository/MoviesRepository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "Televi Flutter",
      home: MultiProvider(
        providers: [
          Provider<MovieRepository>(create: (_) => MovieRepository(client: Client())),
          ProxyProvider<MovieRepository, MoviesBloc>(
            create: (_) => MoviesBloc(movieRepository: null),
            update: (context, repository, bloc) => MoviesBloc(movieRepository: repository),
          )
        ],
        child: MovieList(),
      )
    );
  }
}