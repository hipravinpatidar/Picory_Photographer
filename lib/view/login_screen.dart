import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picory_app/view/register_screen.dart';
import 'package:picory_app/view/verify_otp_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/login_user_provider.dart'; // Updated controller
import '../controllers/language_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_images.dart';
import '../ui_helpers/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final loginController =
        Provider.of<LoginController>(context, listen: false);
    print("Login Called");

    try {
      final phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');
      final formattedPhone = "+91$phone";

      ///  NEW METHOD
      final result = await loginController.checkUserAndSendOTP(formattedPhone);

      if (result['success'] == true && result['registered'] == true) {
        ///  Go to OTP
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => VerifyOtpScreen(phone: phone),
            ),
          );
        }
      } else if (result['registered'] == false) {
        ///  Go to Register Screen
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RegisterScreen(
                phoneController: TextEditingController(text: phone),
              ), //  create this
            ),
          );
        }
      } else {
        /// ⚠ Error
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(result['message'] ?? 'Something went wrong')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.royalPurple,
              AppTheme.deepBlue,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.spacing32),

                  /// Logo
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusLarge),
                      ),
                      child: Image.asset(
                        AppImages.appSplashLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),

                  /// App Name
                  Consumer<LanguageProvider>(
                    builder: (_, lang, __) {
                      return Text(
                        lang.getText('app_name'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing8),

                  /// Tagline
                  Consumer2<LanguageProvider, ThemeProvider>(
                    builder: (_, lang, theme, __) {
                      return Text(
                        lang.getText('tagline'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                          color: theme.isDarkMode
                              ? AppTheme.darkTextSecondary
                              : AppTheme.lightTextSecondary,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing32),
                  const SizedBox(height: AppTheme.spacing16),

                  /// Login Card
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lang.getText('login'),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    lang.getText('welcome_back'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                              const SizedBox(height: AppTheme.spacing16),
                              const SizedBox(height: AppTheme.spacing12),

                              // Phone Field
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: lang.getText('phone'),
                                  labelStyle: const TextStyle(color: Colors.white70),

                                  prefixIcon: const Icon(Icons.phone_outlined,
                                      color: Colors.white),
                                  prefixText: '+91 ',
                                  prefixStyle:
                                      const TextStyle(color: Colors.white),

                                  filled: true,
                                  fillColor:
                                      Colors.transparent, //  FULL TRANSPARENT

                                  //  NORMAL BORDER
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.white70,
                                      width: 1.5,
                                    ),
                                  ),

                                  //  FOCUSED BORDER
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),

                                  //  ERROR BORDER
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                      width: 1.5,
                                    ),
                                  ),

                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your mobile number';
                                  }
                                  if (value.length != 10) {
                                    return 'Enter valid 10-digit mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: AppTheme.spacing32),

                              // Login Button
                              SizedBox(
                                height: 50,
                                child: Consumer<LoginController>(
                                  builder: (_, controller, __) {
                                    return ElevatedButton(
                                      onPressed: controller.isLoading
                                          ? null
                                          : _handleLogin,
                                      child: controller.isLoading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(lang.getText('login')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing32),
                  const SizedBox(height: AppTheme.spacing32),
                  const SizedBox(height: AppTheme.spacing32),

                  /// Powerd By
                  Consumer2<LanguageProvider, ThemeProvider>(
                    builder: (_, lang, theme, __) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            lang.getText('powerd_by'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: theme.isDarkMode
                                  ? AppTheme.darkTextSecondary
                                  : AppTheme.lightTextSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lang.getText('team_picory'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: theme.isDarkMode
                                  ? Colors.white
                                  : AppTheme
                                      .royalPurple, // Stylish accent color
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
