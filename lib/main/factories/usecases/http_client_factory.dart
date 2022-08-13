import 'package:http/http.dart';

import '../../../infra/http/http.dart';

HttpAdapter makeClient() => HttpAdapter(client: Client());
