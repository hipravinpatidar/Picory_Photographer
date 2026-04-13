import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/login_user_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_images.dart';
import '../ui_helpers/app_theme.dart';
import 'main_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;

  const VerifyOtpScreen({super.key, required this.phone});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String otpCode = "";

  void _verifyOtp() async {
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid OTP")),
      );
      return;
    }

    final authProvider = Provider.of<LoginController>(context, listen: false);
    bool isVerified = await authProvider.verifyOTP(otpCode);

    if(isVerified)

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpFields() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,

      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white, //  WHITE TEXT
      ),

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 55,
        fieldWidth: 45,

        //  TRANSPARENT BACKGROUND
        activeFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        inactiveFillColor: Colors.transparent,

        //  WHITE BORDERS
        activeColor: Colors.white,
        selectedColor: Colors.white,
        inactiveColor: Colors.white70,
      ),

      enableActiveFill: true,

      cursorColor: Colors.white, //  cursor bhi white

      onChanged: (value) {
        otpCode = value;
      },

      onCompleted: (value) {
        otpCode = value;
        _verifyOtp();
      },
    );
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
            padding: const EdgeInsets.all(AppTheme.spacing12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing32),

                /// LOGO
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    ),
                    child: Image.asset(
                      AppImages.appSplashLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),

                /// APP NAME
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

                /// TAGLINE
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

                /// OTP CARD
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
                              "Verify OTP",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "OTP sent to ${widget.phone}",
                              style: const TextStyle(fontSize: 14),
                            ),

                            const SizedBox(height: AppTheme.spacing24),

                            /// OTP FIELDS (6 boxes)
                            _buildOtpFields(),
                            const SizedBox(height: AppTheme.spacing24),

                            /// VERIFY BUTTON
                            SizedBox(
                              height: 50,
                              child: Consumer<LoginController>(
                                builder: (BuildContext context, authController, Widget? child) {
                                  return ElevatedButton(
                                    onPressed: authController.isLoading ? null : _verifyOtp,
                                    child: authController.isLoading
                                        ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                        : const Text("Verify OTP"),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacing16),

                            /// RESEND OTP
                            Column(
                              children: [
                                const SizedBox(height: AppTheme.spacing8),

                                Text(
                                  "Didn’t receive the code?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white60,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("OTP Resent")),
                                    );
                                  },
                                  child: const Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline, //  premium touch
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                                : AppTheme.royalPurple, // Stylish accent color
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
    );
  }
}