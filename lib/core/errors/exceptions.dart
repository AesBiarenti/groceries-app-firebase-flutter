/// Exceptions thrown by data layer.
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Sunucu hatası']);
}

class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Kimlik doğrulama hatası']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Önbellek hatası']);
}
