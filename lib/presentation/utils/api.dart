import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const api = "http://10.0.2.2:7254";

String? apiKey = dotenv.env['API_KEY'];
late String newsApi;

void initializeNewsApi() {
  newsApi =
  "https://newsdata.io/api/1/news?category=business&language=en&${apiKey ?? ''}";
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}