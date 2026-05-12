# Resumen General de Mejoras (VitalTrack MVP)

Tras completar el MVP, se identifican tres pilares fundamentales para mejorar en futuras iteraciones:

### 1. Robustez del Entorno (Multi-plataforma)
*   **Web Support**: La decisión de usar SQLite nativo limitó la ejecución en Web. Para el futuro, se debe priorizar una capa de persistencia condicional (WASM para Web, Native para Mobile) desde el diseño de la arquitectura.

### 2. Estándares de Internacionalización
*   **Detección de Hardcoded Strings**: Hubo varias vueltas de revisión para localizar mensajes de error. Se recomienda usar herramientas de análisis estático que obliguen al uso de ARB files para cualquier String visible en la capa de `presentation`.

### 3. Automatización de Sincronización
*   **Workmanager**: La inicialización en segundo plano es compleja debido a la necesidad de re-instanciar Firebase y los contenedores de Riverpod.
*   **Mejora**: Crear una clase de "Inyección de Dependencias para Background" compartida entre el `main` y el `callbackDispatcher` para asegurar consistencia absoluta en los servicios.

### 4. Cobertura de Tests
*   **Integración Real**: Aunque los tests unitarios y de widget son sólidos (34 tests), falta una suite de **Integration Tests** (E2E) que verifique el flujo real de Auth -> Health Sync -> Dashboard en un dispositivo físico.
