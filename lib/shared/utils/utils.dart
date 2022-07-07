import 'dart:convert';

import 'package:crypto/crypto.dart';

class Utils {
  const Utils();

  static String generateSHA256Hash(String password) {
    final bytes = utf8.encode(password);
    final passwordHash = sha256.convert(bytes).toString();
    return passwordHash;
  }
}
