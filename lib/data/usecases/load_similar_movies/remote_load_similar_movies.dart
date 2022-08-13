import 'package:the_movie_db/data/models/models.dart';
import 'package:the_movie_db/domain/entities/movie_entity.dart';

import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

class RemoteLoadSimilarMovies implements LoadSimilarMovies {
  final HttpClient client;
  final String url;

  RemoteLoadSimilarMovies({required this.client, required this.url});

  @override
  Future<List<MovieEntity>> load() async {
    final json = await client.request(url: url, method: "get");
    return json["results"]
        .map<MovieEntity>((json) => RemoteMovieModel.fromJson(json).toEntity())
        .toList();
  }
}
