import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';
import '../movie.dart';

part 'load_movie_event.dart';
part 'load_movie_state.dart';

extension MovieEntityExtension on MovieEntity {
  MovieViewModel toViewModel() {
    return MovieViewModel(
      name: name,
      imageUrl: imageUrl,
      popularity: popularity,
      likes: likes,
    );
  }
}

class LoadMovieBloc extends Bloc<LoadMovieEvent, LoadMovieState> {
  final LoadMovie loadMovie;

  LoadMovieBloc({
    required this.loadMovie,
  }) : super(LoadMovieInitial()) {
    on<LoadingMovieEvent>((event, emit) async {
      final movie = await loadMovie.load();
      emit(LoadMovieSuccess(movie.toViewModel()));
    });
  }
}
