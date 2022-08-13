import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:the_movie_db/data/http/http.dart';
import 'package:the_movie_db/data/usecases/usecases.dart';
import 'package:the_movie_db/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockLoadCall() =>
      when(() => request(url: any(named: 'url'), method: any(named: 'method')));
  void mockRequest(Map json) => mockLoadCall().thenAnswer((_) async => json);
}

void main() {
  late LoadMovie sut;
  late String url;
  late HttpClientSpy httpClient;

  setUp(() {
    url = faker.internet.httpsUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadMovie(url: url, client: httpClient);
    httpClient.mockRequest({"any": "any"});
  });

  test("Should call HttpClient with correct values", () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });
}
