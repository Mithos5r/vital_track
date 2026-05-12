# Informe de Bloqueo en Plataforma Web (Chrome)

## 🔍 Resumen
La aplicación VitalTrack actualmente no es funcional en la plataforma Web debido a incompatibilidades críticas con los paquetes de persistencia y tareas en segundo plano utilizados para la experiencia nativa.

## 🛠 Bloqueadores Detectados

### 1. Drift (Persistencia Local)
*   **Error**: `drift_flutter` requiere archivos binarios de SQLite compilados a WebAssembly (`sqlite3.wasm`) y un worker de JavaScript (`sqlite3.js`) alojados en la carpeta `web/` para funcionar en el navegador.
*   **Estado**: Actualmente, aunque la aplicación compila, el motor de la base de datos falla al inicializarse porque no encuentra estos recursos estáticos.

### 2. Workmanager (Sincronización en Segundo Plano)
*   **Error**: El paquete `workmanager` es una implementación exclusiva para **iOS (Background Tasks)** y **Android (JobScheduler/WorkManager)**.
*   **Impacto**: Al intentar inicializarse en Web, el código lanza una excepción de `Unsupported operation: Platform._operatingSystem` (vía `dart:io`), lo cual detiene el flujo de arranque de los servicios de salud.

### 3. Health API & Permission Handler
*   **Error**: Los paquetes `health` y `permission_handler` dependen de APIs nativas de Apple HealthKit y Google Fit/Health Connect que no existen en el entorno web estándar.

## 💡 Recomendaciones para Soporte Web Futuro
1.  **Refactorización de Base de Datos**: Migrar a una implementación condicional que use `IndexedDB` o configurar el pipeline de WASM para SQLite.
2.  **Abstracción de Servicios**: Implementar "No-op" services para Web en `BackgroundSyncService` y `HealthAppDataSource` para evitar crashes por llamadas a `dart:io`.
3.  **Enfoque Actual**: VitalTrack está diseñado como una aplicación **Mobile-First** para maximizar la privacidad y la integración con sensores nativos.
