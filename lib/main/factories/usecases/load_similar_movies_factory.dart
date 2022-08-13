import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import 'usecases.dart';

LoadSimilarMovies makeLoadSimilarMovies() => RemoteLoadSimilarMovies(
    client: makeClient(),
    url: makeUrl("550/similar?api_key=${"api_key_here"}"));
