import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovie implements LoadMovie {
  final String url;
  final HttpClient client;

  RemoteLoadMovie({required this.url, required this.client});

  @override
  Future<MovieEntity> load() async {
    await client.request(url: url, method: 'get');
    final json = {"name": "any", "popularity": "2.5"};
    return RemoteMovieModel.fromJson(json).toEntity();
  }
}
