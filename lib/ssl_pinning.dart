import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class HttpSSLPinning {
  static Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/themoviedb-org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> getSecureClient() async {
    HttpClient httpClient = HttpClient(context: await globalContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return new IOClient(httpClient);
  }

  static Future<http.Client> get _instance async =>
      _clientInstance ??= await getSecureClient();
  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
