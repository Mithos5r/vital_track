# Project Context: VitalTrack (Health & AI Assistant)

## 1. Visión General
VitalTrack es una aplicación móvil de salud diseñada para el seguimiento diario de métricas biométricas y actividad física. El objetivo principal es permitir al usuario centralizar su información de salud de forma local y privada, con una futura integración de IA para análisis predictivo.

## 2. Stack Tecnológico (Restricciones Técnicas)
*   **Framework:** Flutter (Latest Stable).
*   **Gestión de Estado:** Riverpod (usando Code Generation con `@riverpod`).
*   **Autenticación:** Firebase Auth (Email/Password).
*   **Persistencia Local:** Drift (usando drift_dev para generación de código). Los datos de salud NUNCA se suben a Firebase en esta fase; se quedan en el dispositivo.
*   **Arquitectura:** Clean Architecture simplificada (Data, Domain, Presentation).

## 3. Entidades y Modelos de Datos
Cada registro de salud debe contener:
*   `id` (UUID/Int)
*   `user` (UUID/String del usuario)
*   `timestamp` (DateTime)
*   `heart_rate` (int?) - Pulsaciones por minuto.
*   `blood_oxygen` (double?) - Porcentaje.
*   `steps` (int?)
*   `calories_burned` (int?)
*   `exercise_type` (String?)
*   `exercise_duration` (int?) - Minutos.

## 4. Funcionalidades (Scope Actual)
1.  **Auth Flow:** Pantallas de Login y Registro conectadas a Firebase.
2.  **Data Entry:** Formulario validado para insertar las métricas mencionadas.
3.  **Dashboard:** Visualización del histórico del usuario filtrado por UUID de Firebase (listado y resumen del día).
4.  **Local Storage:** CRUD completo en Drift(SQLite) para las métricas.
5.  **App salud nativas:** Obtención de los datos de las app nativas del sistema operativo iOS y Android. 

## 5. Roadmap & Contexto Futuro
*   **Gemini Chat:** Se implementará un chat que consumirá el historial de Drift(SQLite). El código debe estar preparado para extraer reportes en JSON que se enviarán al modelo como contexto para consejos de salud.

## 6. Reglas de Estilo y Código
*   **Naming:** Clases en PascalCase, variables y funciones en camelCase.
*   **UI:** Seguir las guías de Material Design 3.
*   **Assets:** Todos los assets como imagenes estan situados en la carpeta assets, utiliza flutter_gen_runner y flutter_gen para acceder a ellos. Nunca ponga el path en el código.
*   **Inmutabilidad:** Usar @inmutable de meta y copyWith para modelos de datos y estados.
*   **Riverpod:** Preferir `AsyncNotifier` para peticiones a base de datos."Usa siempre el paquete riverpod_generator. No crees Providers manualmente si pueden ser generados.
*   **Comentarios:** Documentar el "por qué" de las funciones complejas en ingles.
*   **Navegación:**  Utiliza go_router para realizar la navegación. La navegación mediante go_router debe usar un refreshListenable basado en el estado de autenticación de Firebase para redirigir automáticamente al /login si la sesión expira o se cierra

## 7. Tematización (Material 3)
* **Colores:** Definir en core/theme. Se creará un archivo para los colore s donde se definiran todos los colores como constantes dentro de una clase VitalTrackColors. Se creará otro archivo donde se definirá `AppTheme` usando `ColorScheme.fromSeed` con el verde (#4caf50) como semilla.
* **Componentes:** Los componentes generales se difinirán detro de la carpeta core/theme/{componente} un ejemplo de los componentes que irán son:
    * Los `Card` deben tener una elevación de 0 y un borde suave (Outline).
    * Los `TextFormField` deben usar `border: OutlineInputBorder()` y `filled: true`.
    * Los `SnackBar` cuando son de error deben de tener el borde de color #FD574B, el background color #FFF3F0 y el texto principal color #830002 y el texto color #394352
* **Tipografía:** Utilizar los estilos `headlineSmall` para títulos de Bento Box y `bodyMedium` para datos.

## 8. Pantallas, Flujo de Navegación y Manejo de Errores

### Reglas Generales de UI y Errores
* **Nombre de la App:** VitalTrack.
* **Paleta de Colores:** Verde (Primary: #4caf50), Azul Celeste (Secondary), Blanco (Background).
* **Errores de Formulario:** Se deben mostrar mediante el `validator` de los campos de texto, apareciendo justo debajo de cada field.
* **Errores de Servidor/Firebase:** Se mostrarán mediante un `SnackBar` de error en la parte inferior.
    * Si el usuario no existe: "el usuario no existe".
    * Si el email/password es incorrecto: "usuario o contraseña incorrecto".
    * Si se intenta crear una cuenta con un email ya registrado: Mostrar un error genérico (ej: "Error al crear la cuenta, intente de nuevo").
* **Carga:** Para los estados de carga usa el package skeletonizer: ^2.1.3 o Utiliza un `CircularProgressIndicator` centrado
* **Empty State:** Si el histórico o el dashboard no tienen datos, mostrar el asset `assets/empty_data.svg` con un texto descriptivo.

### Detalle de Pantallas

1. **Splash Screen (`/splash`)**
    * **Diseño:** Pantalla completamente verde.
    * **Centro:** `assets/splash.gif`.
    * **Inferior:** Texto "Cargando..." en blanco.
    * **Lógica:** Decisión de ruta automática. Si el usuario está autenticado en Firebase -> `/home`, de lo contrario -> `/login`.

2. **Login Screen (`/login`)**
    * **Header:** Logo centrado `assets/logo.svg`.
    * **Campos:** Email y Contraseña.
    * **Validación Local:** Email con formato válido; Contraseña no vacía.
    * **Acción:** Botón "Acceder". Si Firebase devuelve error, disparar `SnackBar` rojo con los mensajes definidos arriba.
    * **Navegación:** Link inferior "Crear usuario" que navega a Register.

3. **Register Screen (`/register`)**
    * **Header:** Logo `assets/logo.svg`.
    * **Campos:** Email, Contraseña y Confirmar Contraseña.
    * **Validación Local:** * Email válido.
        * Contraseñas deben coincidir.
        * Requisitos de Password: Mínimo 6 caracteres, una mayúscula, una minúscula, un número y un carácter especial.
    * **Acción:** Botón "Crear cuenta". En caso de conflicto de usuario existente, mostrar error genérico en `SnackBar`.

4. **Home/Dashboard (`/home`)**
    * **AppBar:** Título "VitalTrack" a la izquierda; Icono `+` a la derecha que navega a `AddEntryForm`.
    * **Body:** Diseño basado en **Bento Box**. Cada celda contiene el dato (heart rate, steps, etc.) y su icono correspondiente (`assets/{dato}.svg`). Los datos de `exercise_type` y `exercise_duration` van juntos en el mismo bento que ocupa el doble que los otros.
    * **Interacción:** Al pulsar un bento, se navega al histórico específico de ese parámetro. Para el bento de `exercise` se navegará con el parametro `exercise`.
    * **Empty State:** En caso de estar vacio, aparecerá el icono assets/empty_data_home.svg con un texto que ponga "No esperes más. Pulsa + para añadir datos"
    * **FAB:** Botón flotante centrado con icono `+` para navegar a `AddEntryForm`.

5. **Histórico Screen (`/history/:param`)**
    * **AppBar:** Nombre del parámetro (ej: "Pulsaciones"). 
    * **Body:** Scroll infinito (`ListView.builder`).
    * **Tile:** A la izquierda el valor numérico, a la derecha el `DateTime` formateado del registro. Para el `exercise` se monstrará a la izquierda el nombre del ejercicio y debajo de el tiempo del ejercicio en minutos.
    * **Empty State:** En caso de estar vacio, aparecerá el icono assets/empty_data_home.svg con un texto que ponga "No hay registros disponibles para `:param`"

6. **AddEntryForm Screen (`/add-entry`)**
    * **Formulario:** Todos los campos definidos en la entidad (sección 3).
    * **Validación:** Los campos pueden estar vacios. Los campos numéricos deben usar `KeyboardType.number` y validar que el input sea un número válido antes de guardar. Para los campos de `exercise_type` y `exercise_duration` si esta uno tiene que estar obligatoriamente el otro. Si todos los campos estan vacios no se podrá guardar.
    * **Acción:** Botón inferior "Guardar" que persiste el dato en SQLite localmente.

## 9. Estructura de Directorios
Seguir estrictamente:
- `lib/core/`: Utilidades, temas, constantes y routers.
- `lib/data/firebase_auth`: Firebase auth, manejo de la sesión con firebase, endpoint de login y crear usuario.
- `lib/data/{feature_name}`: Repositorios y DataSources.
- `lib/domain/{feature_name}`: Entidades y casos de uso.
- `lib/presentation/{feature_name}`: Widgets, pantallas y providers (AsyncNotifier).

## 10. Definición de Base de Datos
- **Table:** `health_metrics`
- **Columns:** `id` (integer().autoIncrement()()), `user`(text()(); // UID de Firebase), `timestamp` (dateTime()();), `heart_rate` (integer().nullable()()), `blood_oxygen` (real().nullable()()), `steps` (integer().nullable()()), `calories_burned` (integer().nullable()()), `exercise_type` (text().nullable()()), `exercise_duration` (integer().nullable()()).

## 11. Internacionalización
* **Herramienta:** Utilizar el sistema nativo de Flutter (`flutter_localizations` y archivos `.arb`).
* **Idioma Base:** Español (es).
* **Regla:** No escribir strings directamente en los widgets; usar siempre `AppLocalizations.of(context)!`.

## 12. Generación de splash nativo e icono
* **Herramienta:** Utilizar los packages `flutter_native_splash`:2.4.7  y `flutter_launcher_icons`:0.14.4.
* **Pipeline de Generación:** Utilizar cada vez que se quiera generar el splash nativo o los launcher icons:
1. `dart run flutter_native_splash:create --path=assets/native_splash/config.yaml`
2. `dart run flutter_launcher_icons -f ./assets/launcher_icon/config.yaml`

## 13. Integración con app nativas
* **Herramienta:** Utilizar el package `health`: ^13.3.1
* **Integración:** 
    1. Configuración e Instalación:
       * Integrar health, shared_preferences y workmanager.
       * Configurar permisos nativos (Android/iOS) para datos médicos y tareas en segundo plano.

    2. Fuentes de Datos (Data Sources):
       * SharedPreferencesDataSource: Manejará tanto el last_sync_timestamp como un nuevo flag booleano
         stop_background_sync (para pausar reintentos si falla la autenticación).
       * HealthAppDataSource: Abstraerá las consultas al SO para obtener los datos.

    3. Lógica del Caso de Uso (Sincronización):
       * Verificación: Leer el flag stop_background_sync. Si es true o no hay usuario de Firebase,
         cancelar y registrar true en el flag.
       * Ventana de Tiempo: Del last_sync_timestamp (o hace 15 mins) hasta now().
       * Segmentación: Dividir la ventana total de tiempo en bloques de 1 hora.
       * Agrupación: Para cada bloque de 1 hora, obtener los datos del SO, hacer medias/sumas ignorando
         vacíos, y crear un HealthMetricEntity (con nulos donde aplique).
       * Persistencia: Guardar todos los bloques generados en SQLite y actualizar el last_sync_timestamp
         a la última hora procesada.

    4. Ejecución y Reactivación:
       * Configurar workmanager para disparar el proceso cada hora.
       * En el código de la UI principal (al abrir la app / main.dart), añadir un mecanismo que resetee
         el flag stop_background_sync a false para que las tareas en background vuelvan a intentarse.

## 14. Estrategia de Testing
* **Unit Tests:** Obligatorios para los `DataSources` (mockeando SQLite) y los `UseCases`.
* **Mocks:** Utilizar el paquete `mocktail` para las dependencias.
* **Localización:** Los tests deben residir en la carpeta `test/` siguiendo la misma estructura que `lib/`.

## 15. Pipeline de Generación
Cada vez que se modifique un modelo o un provider, se debe ejecutar:
1. `dart run build_runner build --delete-conflicting-outputs`
2. `flutter gen-l10n`

