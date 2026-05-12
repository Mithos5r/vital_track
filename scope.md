# Project Scope: VitalTrack MVP

## 1. Objetivos del MVP
Lanzar una herramienta funcional de seguimiento de salud local con autenticación segura y visualización de datos básica.

## 2. Funcionalidades Incluidas (In-Scope)
* Auth: Flujo completo Firebase (Login/Registro/Logout).
* Local DB: CRUD de métricas biométricas (Heart Rate, Steps, etc.).
* UI: Dashboard tipo Bento Box y navegación con GoRouter.
* I18n: Soporte completo para español.
* Integración con app nativas: Obtención de los datos de las app nativas.

## 3. Fuera de Alcance (Out-of-Scope)
* Recuperación de contraseña vía SMS.
* Gráficos avanzados (LineCharts, BarCharts) - *Solo se usará el listado por ahora*.
* Notificaciones Push.
* Soporte para tablets (Layout optimizado solo para móvil).

## 4. Restricciones de Datos
* Los datos de salud NO deben tocar la nube de Firebase bajo ninguna circunstancia en esta versión.
* El historial de SQLite debe ser capaz de exportarse como un String JSON plano para el futuro chat de IA.