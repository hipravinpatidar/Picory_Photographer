import 'package:flutter/material.dart';
import 'package:picory_app/view/register_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_theme.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );

    // if (_formKey.currentState!.validate()) {
    //   setState(() => _isLoading = true);
    //
    //   // Simulate API call
    //   await Future.delayed(const Duration(seconds: 2));
    //
    //   if (mounted) {
    //     setState(() => _isLoading = false);
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const MainScreen()),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing32),

                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.royalPurple, AppTheme.accentPurple],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.royalPurple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),

                // Welcome Text
                Consumer<LanguageProvider>(
                  builder: (_, lang,__) { 
                    return Text(
                      lang.getText('app_name'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacing8),

                Consumer2<LanguageProvider,ThemeProvider>(
                  builder: (_, lang, theme,__) {
                    return Text(
                      lang.getText('tagline'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.isDarkMode ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacing32),

                // Login Card
                Consumer<LanguageProvider>(
                  builder: (_, lang, __) {
                    return Card(
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacing24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              lang.getText('login'),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacing24),

                            // Email/Phone Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: lang.getText('email'),
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: AppTheme.spacing16),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: lang.getText('password'),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() => _obscurePassword = !_obscurePassword);
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: AppTheme.spacing12),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  lang.getText('forgot_password'),
                                  style: const TextStyle(color: AppTheme.royalPurple),
                                ),
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacing24),

                            // Login Button
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                child: _isLoading
                                    ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Text(lang.getText('login')),
                              ),
                            ),

                            const SizedBox(height: AppTheme.spacing16),

                            // Register Button
                            SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                  );
                                },
                                child: Text(lang.getText('register')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}