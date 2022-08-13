import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:the_movie_db/data/http/http.dart';
import 'package:the_movie_db/infra/http/http.dart';

class ClientSpy extends Mock implements Client {
  ClientSpy() {
    mockPost(200);
    mockPut(200);
    mockGet(200);
  }

  When mockPostCall() => when(() => this
      .post(any(), body: any(named: 'body'), headers: any(named: 'headers')));
  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));

  When mockPutCall() => when(() => this
      .put(any(), body: any(named: 'body'), headers: any(named: 'headers')));
  void mockPut(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPutCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPutError() => when(() => mockPutCall().thenThrow(Exception()));

  When mockGetCall() =>
      when(() => this.get(any(), headers: any(named: 'headers')));
  void mockGet(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockGetCall().thenAnswer((_) async => Response(body, statusCode));
  void mockGetError() => when(() => mockGetCall().thenThrow(Exception()));
}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client: client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  test("Should throw ServerError if invalid method is provided", () async {
    final future = sut.request(url: url, method: 'invalid_method');

    expect(future, throwsA(HttpError.serverError));
  });

  test("Should call post with correct values", () async {
    await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});
    verify(() => client.post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: '{"any_key":"any_value"}'));

    await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
        headers: {'any_header': 'any_value'});
    verify(() => client.post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'any_header': 'any_value'
        },
        body: '{"any_key":"any_value"}'));
  });

  test('Should call post without body', () async {
    await sut.request(url: url, method: 'post');

    verify(() => client.post(any(), headers: any(named: 'headers')));
  });
}
