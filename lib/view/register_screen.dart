import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../ui_helpers/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (_, lang, __) {
            return Text(lang.getText('register'));
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing16),

                // Register Card
                Consumer<LanguageProvider>(
                  builder: (_, languageProvider, __) {
                    return Card(
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacing24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Full Name
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText:
                                    languageProvider.getText('full_name'),
                                prefixIcon: const Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languageProvider.getText('enter_name');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppTheme.spacing16),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: languageProvider.getText('email'),
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languageProvider
                                      .getText('enter_email');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppTheme.spacing16),

                            // Phone
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: languageProvider.getText('phone'),
                                prefixIcon: const Icon(Icons.phone_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languageProvider
                                      .getText('enter_phone');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppTheme.spacing16),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: languageProvider.getText('password'),
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languageProvider
                                      .getText('enter_password');
                                }
                                if (value.length < 6) {
                                  return languageProvider
                                      .getText('password_length');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppTheme.spacing16),

                            // Confirm Password
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: languageProvider
                                    .getText('confirm_password'),
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languageProvider
                                      .getText('confirm_password');
                                }
                                if (value != _passwordController.text) {
                                  return languageProvider
                                      .getText('password_not_match');
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppTheme.spacing32),

                            // Register Button
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleRegister,
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        languageProvider.getText('register')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
