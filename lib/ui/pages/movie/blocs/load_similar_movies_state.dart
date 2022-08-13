part of 'load_similar_movies_bloc.dart';

@immutable
abstract class LoadSimilarMoviesState {}

class LoadSimilarMoviesInitial extends LoadSimilarMoviesState {}

class LoadSimilarMovieSuccess extends LoadSimilarMoviesState {
  final List<MovieViewModel> movies;

  LoadSimilarMovieSuccess(this.movies);
}

class LoadSimilarMovieError extends LoadSimilarMoviesState {
  final String error;

  LoadSimilarMovieError(this.error);
}
