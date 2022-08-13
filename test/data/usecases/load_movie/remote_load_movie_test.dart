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

  setUp(() {
    url = faker.internet.httpsUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest({"name": "any_name", "popularity": "1.0"});
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
}
