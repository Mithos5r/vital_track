// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'VitalTrack';

  @override
  String get loading => 'Cargando...';

  @override
  String get login => 'Acceder';

  @override
  String get register => 'Crear cuenta';

  @override
  String get email => 'Email';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get errorUserNotFound => 'el usuario no existe';

  @override
  String get errorWrongPassword => 'usuario o contraseña incorrecto';

  @override
  String get errorGenericAuth => 'Error al crear la cuenta, intente de nuevo';

  @override
  String get homeTitle => 'VitalTrack';

  @override
  String get noDataHome => 'No esperes más. Pulsa + para añadir datos';

  @override
  String noDataHistory(String param) {
    return 'No hay registros disponibles para $param';
  }

  @override
  String get save => 'Guardar';

  @override
  String get heartRate => 'Pulsaciones';

  @override
  String get bloodOxygen => 'Oxígeno en sangre';

  @override
  String get steps => 'Pasos';

  @override
  String get calories => 'Calorías';

  @override
  String get exercise => 'Ejercicio';

  @override
  String get sleep => 'Sueño';

  @override
  String get fieldRequired => 'Campo requerido';

  @override
  String get invalidEmail => 'Email inválido';

  @override
  String get passwordTooShort => 'Mínimo 6 caracteres';

  @override
  String get passwordRequiresUppercase => 'Requiere una mayúscula';

  @override
  String get passwordRequiresLowercase => 'Requiere una minúscula';

  @override
  String get passwordRequiresNumber => 'Requiere un número';

  @override
  String get passwordRequiresSpecialChar => 'Requiere un carácter especial';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get errorAtLeastOneField => 'Debe rellenar al menos un campo';

  @override
  String get exerciseType => 'Tipo de ejercicio';

  @override
  String get exerciseDuration => 'Duración (minutos)';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get recordDeleted => 'Registro eliminado';

  @override
  String get syncErrorTitle => 'Error de Sincronización';

  @override
  String get syncErrorMessage =>
      'La sincronización de salud se ha detenido por falta de permisos. Por favor, actívalos en los ajustes del sistema.';

  @override
  String get close => 'Cerrar';

  @override
  String get settings => 'Ir a Ajustes';
}
