/// Domain-level failure (e.g. for Clean Architecture).
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Sunucu hatası']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Giriş hatası']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Önbellek hatası']);
}
