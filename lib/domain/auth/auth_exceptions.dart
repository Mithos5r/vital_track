sealed class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('el usuario no existe');
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('usuario o contraseña incorrecto');
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException() : super('Error al crear la cuenta, intente de nuevo');
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super('Error al crear la cuenta, intente de nuevo');
}

class GenericAuthException extends AuthException {
  GenericAuthException() : super('Error al crear la cuenta, intente de nuevo');
}
