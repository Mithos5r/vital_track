import '../../l10n/app_localizations.dart';

sealed class AuthException implements Exception {
  String getLocalizedMessage(AppLocalizations l10n);
}

class UserNotFoundException extends AuthException {
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorUserNotFound;
}

class WrongPasswordException extends AuthException {
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorWrongPassword;
}

class EmailAlreadyInUseException extends AuthException {
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorGenericAuth;
}

class WeakPasswordException extends AuthException {
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorGenericAuth;
}

class GenericAuthException extends AuthException {
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorGenericAuth;
}
