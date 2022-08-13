import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:the_movie_db/data/http/http.dart';
import 'package:the_movie_db/infra/http/http.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    url = faker.internet.httpsUrl();
    client = ClientSpy();
    sut = HttpAdapter(client: client);
  });

  test("Should throw ServerError if invalid method is provided", () async {
    final future = sut.request(url: url, method: 'invalid_method');

    expect(future, throwsA(HttpError.serverError));
  });
}
