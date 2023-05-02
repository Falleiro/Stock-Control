import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('Listening on localhost:${server.port}');

  await for (final request in server) {
    try {
      if (request.method == 'GET') {
        handleGet(request);
      } else if (request.method == 'POST') {
        handlePost(request);
      } else {
        handleInvalidRequest(request);
      }
    } catch (e) {
      print('Exception in handling request: $e');
      handleInvalidRequest(request);
    }
  }
}

void handleGet(HttpRequest request) {
  // handle GET request
}

void handlePost(HttpRequest request) async {
  // handle POST request
  final jsonString = await utf8.decoder.bind(request).join();
  final data = jsonDecode(jsonString);
  // process data
  request.response
    ..headers.contentType = ContentType.json
    ..write(jsonEncode({'success': true}))
    ..close();
}

void handleInvalidRequest(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.badRequest
    ..write('Invalid request')
    ..close();
}
