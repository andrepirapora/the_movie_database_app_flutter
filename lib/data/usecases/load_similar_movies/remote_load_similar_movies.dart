import 'package:the_movie_db/data/models/models.dart';
import 'package:the_movie_db/domain/entities/movie_entity.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

class RemoteLoadSimilarMovies implements LoadSimilarMovies {
  final HttpClient client;
  final String url;

  RemoteLoadSimilarMovies({required this.client, required this.url});

  @override
  Future<List<MovieEntity>> load() async {
    try {
      // descomente essa linha se voce tiver uma API KEY
      // final json = await client.request(url: url, method: "get");
      final json = await _loadMock();
      return json["results"]
          .map<MovieEntity>(
              (json) => RemoteMovieModel.fromJson(json).toEntity())
          .toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<Map> _loadMock() async {
    await Future.delayed(const Duration(seconds: 3));
    return {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path":
              "https://m.media-amazon.com/images/M/MV5BZTg5MjJmMjYtYTVjZC00MzVjLTlhODgtYTQ2YTRiNjlmZDI1XkEyXkFqcGdeQXVyMzMxNzQ3MjI@._V1_.jpg",
          "genre_ids": [28],
          "id": 106912,
          "original_language": "en",
          "original_title": "Darna! Ang Pagbabalik",
          "overview":
              "Valentina, Darna's snake-haired arch enemy, is trying to take over the Phillipines through subliminal messages on religious TV shows. Darna has her own problems, however, as she has lost her magic pearl and with it the ability to transform into her scantily clad super self. Trapped as her alter-ego, the plucky reporter Narda, she must try to regain the pearl and foil Valentina's plans.",
          "release_date": "1994-05-09",
          "poster_path": null,
          "popularity": 1.012564,
          "title": "Darna: The Return",
          "video": false,
          "vote_average": 0,
          "vote_count": 1220
        },
      ],
      "total_pages": 9,
      "total_results": 168
    };
  }
}
