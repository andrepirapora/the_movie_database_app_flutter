import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadMovie implements LoadMovie {
  final String url;
  final HttpClient client;

  RemoteLoadMovie({required this.url, required this.client});

  @override
  Future<MovieEntity> load() async {
    try {
      final json = await client.request(url: url, method: 'get');
      return RemoteMovieModel.fromJson(json).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
