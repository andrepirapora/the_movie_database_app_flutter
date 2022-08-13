import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:the_movie_db/data/http/http.dart';
import 'package:the_movie_db/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockLoadCall() =>
      when(() => request(url: any(named: 'url'), method: any(named: 'method')));

  void mockRequest(Map json) => mockLoadCall().thenAnswer((_) async => json);

  void mockRequestError(HttpError error) => mockLoadCall().thenThrow(error);
}

void main() {
  late RemoteLoadSimilarMovies sut;
  late HttpClientSpy httpClient;
  late String url;
  late int voteCount;

  setUp(() {
    url = faker.internet.httpsUrl();
    voteCount = faker.randomGenerator.integer(1000);
    httpClient = HttpClientSpy();
    sut = RemoteLoadSimilarMovies(client: httpClient, url: url);
    httpClient.mockRequest({
      "results": [
        {
          "backdrop_path": "any_value",
          "release_date": "1994-05-09",
          "popularity": 1.012564,
          "title": "Darna! Ang Pagbabalik",
          "vote_count": voteCount,
        }
      ],
    });
  });

  test("Should call HttpClient with correct values", () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: "get"));
  });
}
