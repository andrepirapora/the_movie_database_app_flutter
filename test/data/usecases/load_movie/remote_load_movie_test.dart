import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:the_movie_db/data/http/http.dart';
import 'package:the_movie_db/data/usecases/usecases.dart';
import 'package:the_movie_db/domain/helpers/helpers.dart';
import 'package:the_movie_db/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockLoadCall() =>
      when(() => request(url: any(named: 'url'), method: any(named: 'method')));

  void mockRequest(Map json) => mockLoadCall().thenAnswer((_) async => json);

  void mockRequestError(HttpError error) => mockLoadCall().thenThrow(error);
}

void main() {
  late LoadMovie sut;
  late String url;
  late HttpClientSpy httpClient;
  late int voteCounts;
  late double popularity;

  setUp(() {
    url = faker.internet.httpsUrl();
    voteCounts = faker.randomGenerator.integer(500);
    popularity = faker.randomGenerator.decimal();
    httpClient = HttpClientSpy();
    httpClient.mockRequest({
      "title": "any_name",
      "backdrop_path": "any_value",
      "popularity": popularity,
      "vote_count": voteCounts
    });
    sut = RemoteLoadMovie(url: url, client: httpClient);
  });

  test("Should call HttpClient with correct values", () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should throw UnexpectedError if HttpClient throws', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return MovieEntity if HttpClient returns 200', () async {
    final movie = await sut.load();

    expect(movie.name, "any_name");
  });
}
