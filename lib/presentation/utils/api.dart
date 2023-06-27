import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiKey = dotenv.env['API_KEY'];

var api = '';
var newsApi = '';

void setupAPI() {

  // Platform isn't available on web.
  // Android has connection issues with localhost. "Connection refused..."
  // https://stackoverflow.com/questions/4905315/error-connection-refused
  // Could be a few other things as well though.
  // https://loi-tran-blog.netlify.app/blog/flutter/flutter%20android%20connectivity%20issues%20-%20connection%20refused
  if (kIsWeb) {
    api = "http://localhost:7254";
  } else {
    api = Platform.isAndroid ? "http://10.0.2.2:7254" : "http://localhost:7254";
  }

  newsApi = "https://newsdata.io/api/1/news?category=business&language=en&${apiKey}";
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}