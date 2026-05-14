import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'VitalTrack'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Acceder'**
  String get login;

  /// No description provided for @register.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get register;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Contraseña'**
  String get confirmPassword;

  /// No description provided for @errorUserNotFound.
  ///
  /// In es, this message translates to:
  /// **'el usuario no existe'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'usuario o contraseña incorrecto'**
  String get errorWrongPassword;

  /// No description provided for @errorGenericAuth.
  ///
  /// In es, this message translates to:
  /// **'Error al crear la cuenta, intente de nuevo'**
  String get errorGenericAuth;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'VitalTrack'**
  String get homeTitle;

  /// No description provided for @noDataHome.
  ///
  /// In es, this message translates to:
  /// **'No esperes más. Pulsa + para añadir datos'**
  String get noDataHome;

  /// No description provided for @noDataHistory.
  ///
  /// In es, this message translates to:
  /// **'No hay registros disponibles para {param}'**
  String noDataHistory(String param);

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @heartRate.
  ///
  /// In es, this message translates to:
  /// **'Pulsaciones'**
  String get heartRate;

  /// No description provided for @bloodOxygen.
  ///
  /// In es, this message translates to:
  /// **'Oxígeno en sangre'**
  String get bloodOxygen;

  /// No description provided for @steps.
  ///
  /// In es, this message translates to:
  /// **'Pasos'**
  String get steps;

  /// No description provided for @calories.
  ///
  /// In es, this message translates to:
  /// **'Calorías'**
  String get calories;

  /// No description provided for @exercise.
  ///
  /// In es, this message translates to:
  /// **'Ejercicio'**
  String get exercise;

  /// No description provided for @sleep.
  ///
  /// In es, this message translates to:
  /// **'Sueño'**
  String get sleep;

  /// No description provided for @fieldRequired.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Email inválido'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get passwordTooShort;

  /// No description provided for @passwordRequiresUppercase.
  ///
  /// In es, this message translates to:
  /// **'Requiere una mayúscula'**
  String get passwordRequiresUppercase;

  /// No description provided for @passwordRequiresLowercase.
  ///
  /// In es, this message translates to:
  /// **'Requiere una minúscula'**
  String get passwordRequiresLowercase;

  /// No description provided for @passwordRequiresNumber.
  ///
  /// In es, this message translates to:
  /// **'Requiere un número'**
  String get passwordRequiresNumber;

  /// No description provided for @passwordRequiresSpecialChar.
  ///
  /// In es, this message translates to:
  /// **'Requiere un carácter especial'**
  String get passwordRequiresSpecialChar;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsDoNotMatch;

  /// No description provided for @errorAtLeastOneField.
  ///
  /// In es, this message translates to:
  /// **'Debe rellenar al menos un campo'**
  String get errorAtLeastOneField;

  /// No description provided for @exerciseType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de ejercicio'**
  String get exerciseType;

  /// No description provided for @exerciseDuration.
  ///
  /// In es, this message translates to:
  /// **'Duración (minutos)'**
  String get exerciseDuration;

  /// No description provided for @invalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Número inválido'**
  String get invalidNumber;

  /// No description provided for @recordDeleted.
  ///
  /// In es, this message translates to:
  /// **'Registro eliminado'**
  String get recordDeleted;

  /// No description provided for @syncErrorTitle.
  ///
  /// In es, this message translates to:
  /// **'Error de Sincronización'**
  String get syncErrorTitle;

  /// No description provided for @syncErrorMessage.
  ///
  /// In es, this message translates to:
  /// **'La sincronización de salud se ha detenido por falta de permisos. Por favor, actívalos en los ajustes del sistema.'**
  String get syncErrorMessage;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ir a Ajustes'**
  String get settings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
