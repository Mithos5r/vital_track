import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/assets.gen.dart';
import '../../core/theme/snack_bar/vital_track_snack_bars.dart';
import '../../core/theme/text_form_field/password_field.dart';
import '../../domain/auth/auth_exceptions.dart';
import '../../l10n/app_localizations.dart';
import 'register_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.fieldRequired;
    if (value.length < 6) return l10n.passwordTooShort;
    
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase) return l10n.passwordRequiresUppercase;
    if (!hasLowercase) return l10n.passwordRequiresLowercase;
    if (!hasDigits) return l10n.passwordRequiresNumber;
    if (!hasSpecialCharacters) return l10n.passwordRequiresSpecialChar;
    
    return null;
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await ref.read(registerControllerProvider.notifier).signUp(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!success && mounted) {
      final error = ref.read(registerControllerProvider).error;
      if (error is AuthException) {
        VitalTrackSnackBars.showError(context, error.getLocalizedMessage(l10n));
      } else {
        VitalTrackSnackBars.showError(context, l10n.errorGenericAuth);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Assets.logo.svg(
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  l10n.register,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.fieldRequired;
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) return l10n.invalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field
                VitalTrackPasswordField(
                  controller: _passwordController,
                  labelText: l10n.password,
                  textInputAction: TextInputAction.next,
                  validator: (v) => _validatePassword(v, l10n),
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                VitalTrackPasswordField(
                  controller: _confirmPasswordController,
                  labelText: l10n.confirmPassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(l10n),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.fieldRequired;
                    if (value != _passwordController.text) return l10n.passwordsDoNotMatch;
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Submit Button
                ElevatedButton(
                  onPressed: state.isLoading ? null : () => _submit(l10n),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
