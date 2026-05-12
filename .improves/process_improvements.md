# Oportunidades de Mejora en el Proceso del MVP

Este documento detalla aspectos técnicos y de flujo de trabajo que podrían haberse optimizado durante el desarrollo de VitalTrack.

## 1. Gestión de Dependencias
*   **Conflictos de Analyzer**: Se produjeron varios cuellos de botella al intentar actualizar Drift y Riverpod simultáneamente debido a las restricciones de `analyzer` y `meta` en el SDK de Flutter.
*   **Mejora**: Realizar un análisis de compatibilidad previo antes de realizar "upgrades" masivos, especialmente en entornos con SDKs fijados.

## 2. Flujo de Navegación y Splash
*   **Sincronización Nativa vs Flutter**: Hubo problemas iniciales con la visualización del Splash debido a la velocidad de resolución de Firebase Auth.
*   **Mejora**: Implementar el `InitializationNotifier` desde el primer día para controlar el ciclo de vida del arranque de forma centralizada, evitando la "pantalla blanca" del sistema de forma proactiva.

## 3. Pruebas de UI (Widget Testing)
*   **Dependencias de GoRouter**: Algunos tests fallaron inicialmente porque el contexto del widget no encontraba el Router al usar `context.pop()`.
*   **Mejora**: Estandarizar un `TestingWrapper` que incluya un Router mockeado o real para todos los tests de pantalla, reduciendo el código repetitivo y los fallos por falta de contexto.

## 4. Agregación de Datos
*   **Lógica de Negocio en Notifiers**: Inicialmente, el Dashboard solo mostraba el último registro global.
*   **Mejora**: Definir las entidades de agregación (`DashboardSummary`) en la capa de dominio desde la fase de diseño para asegurar que el Dashboard sea siempre informativo, independientemente de la densidad de los datos.

## 5. Diseño de Base de Datos
*   **Tipado de IDs**: Se detectó una inconsistencia menor en el manejo de IDs (int vs String) al integrar Firebase UID.
*   **Mejora**: Reforzar el uso de `Strong Typing` en las capas de datos desde el inicio para evitar conversiones innecesarias.
