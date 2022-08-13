import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_db/ui/pages/movie/blocs/load_movie_bloc.dart';

import '../../../../domain/usecases/usecases.dart';
import '../movie.dart';

part 'load_similar_movies_event.dart';
part 'load_similar_movies_state.dart';

class LoadSimilarMoviesBloc
    extends Bloc<LoadSimilarMoviesEvent, LoadSimilarMoviesState> {
  final LoadSimilarMovies similarMovies;
  LoadSimilarMoviesBloc({
    required this.similarMovies,
  }) : super(LoadSimilarMoviesInitial()) {
    on<LoadingSimilarMoviesEvent>((event, emit) async {
      try {
        final movies = await similarMovies.load();
        emit(LoadSimilarMovieSuccess(
            movies.map((movie) => movie.toViewModel()).toList()));
      } catch (error) {
        emit(LoadSimilarMovieError("error"));
      }
    });
  }
}
