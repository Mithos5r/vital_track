# VitalTrack (Health & AI Assistant)

VitalTrack es una aplicación móvil de salud diseñada para el seguimiento diario de métricas biométricas y actividad física, priorizando la privacidad total mediante el almacenamiento local.

## 🚀 ¿Qué hace la app?
VitalTrack permite a los usuarios centralizar su información de salud en un solo lugar:
*   **Autenticación Segura**: Gestión de usuarios mediante Firebase Auth (solo identidad, no datos).
*   **Dashboard Bento Box**: Visualización intuitiva de las métricas más recientes (Pulsaciones, Pasos, Oxígeno, Calorías y Ejercicio).
*   **Entrada de Datos**: Formulario validado para registrar métricas manualmente.
*   **Historial Detallado**: Listado cronológico de registros con capacidad de borrado granular por métrica.
*   **Sincronización Nativa**: Integración con Apple Health y Google Fit para importar datos automáticamente cada hora.
*   **Exportación de Datos**: Capacidad de generar un JSON con el historial de los últimos 7 días para compartirlo o procesarlo externamente.

## 🛠 Cómo ejecutarla

### Requisitos previos
*   Flutter SDK (^3.11.3)
*   Dart SDK (^3.11.3)
*   CocoaPods (para iOS)

### Pasos de ejecución
1.  **Clonar el repositorio**.
2.  **Sincronizar dependencias**:
    ```bash
    flutter pub get
    ```
3.  **Generar archivos de código**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Generar localizaciones**:
    ```bash
    flutter gen-l10n
    ```
5.  **Lanzar la aplicación**:
    ```bash
    flutter run
    ```

### 📱 Estado de Plataformas
*   **iOS**: ✅ **Totalmente funcional**. Soporta HealthKit y sincronización nativa.
*   **Android**: ✅ **Funcional**. Requiere `minSdkVersion 26` (configurado automáticamente). Soporta Google Fit / Health Connect.
*   **Web**: ❌ **Bloqueado**. La arquitectura actual usa `sqlite3` vía FFI nativo e integraciones de salud no disponibles en el navegador. (Ver `web_launch_error.md`).

## 🧠 Decisiones Técnicas

*   **Arquitectura Limpia (Clean Architecture)**: Se organizó el código en capas (`data`, `domain`, `presentation`) para asegurar que la lógica de negocio sea independiente de las librerías externas (como Firebase o el plugin de salud).
*   **Local-First (Drift/SQLite)**: Los datos de salud residen exclusivamente en el dispositivo para garantizar la privacidad del usuario, cumpliendo con la restricción de que los datos biométricos no toquen la nube.
*   **Riverpod 3.x + Generator**: Se utilizó la última versión de Riverpod para una gestión de estado reactiva y segura en tiempo de ejecución, facilitando la actualización automática del Dashboard tras cambios en el historial.
*   **GoRouter con Navegación Reactiva**: La navegación reacciona automáticamente al estado de Firebase Auth, actuando como un "guardián" de rutas.
*   **Agregación Independiente**: La lógica de visualización busca el dato más reciente de cada métrica de forma independiente, asegurando un Dashboard siempre informativo incluso con entradas parciales.

## 🤖 Uso de IA (Gemini CLI)

Este proyecto ha sido desarrollado íntegramente mediante **Gemini CLI**, actuando como un agente de ingeniería de software autónomo:
*   **Orquestación**: La IA gestionó la creación de archivos, configuración de dependencias y resolución de conflictos de versiones.
*   **Investigación**: Se realizaron búsquedas en vivo en la documentación de paquetes (`drift`, `riverpod`, `health`) para implementar las mejores prácticas de migración.
*   **Calidad Automática**: Tras cada cambio, la IA ejecutó el analizador y la suite de tests para asegurar que no hubiera regresiones.
*   **Refactorización**: Gemini ayudó a mover lógica nativa (Workmanager) a abstracciones de dominio para mantener la arquitectura limpia.

## 🔮 Mejoras Futuras

Si contara con más tiempo, estas serían las prioridades:
1.  **Asistente de IA Integrado**: Utilizar el JSON exportado para alimentar un modelo de lenguaje local que ofrezca recomendaciones de salud personalizadas.
2.  **Soporte Web (WASM)**: Configurar Drift para usar SQLite compilado a WebAssembly y permitir la ejecución en navegadores.
3.  **Visualización de Tendencias**: Añadir gráficos (vía `fl_chart`) en la pantalla de historial para observar la evolución de las métricas a lo largo del tiempo.
4.  **Notificaciones Push**: Avisar al usuario si la sincronización en segundo plano se detiene por falta de permisos o si se detectan anomalías en las métricas.
5.  **Splash nativo Android**: El splash nativo de android no se ve correctamente para dispositivos de android 12 o superior.
6.  **Github action**: Añadir todo el sistema de github action.
