// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../controllers/language_provider.dart';
// import '../controllers/register_user_provider.dart';
// import '../controllers/theme_provider.dart';
// import '../ui_helpers/app_images.dart';
// import '../ui_helpers/app_theme.dart';
// import '../ui_helpers/comman_widgets.dart';
// import 'main_screen.dart';
//
// class RegisterScreen extends StatefulWidget {
//   TextEditingController? phoneController;
//   RegisterScreen({super.key, this.phoneController});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _businessNameController = TextEditingController();
//   final _emailController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _businessNameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   void _handleRegister() async {
//     if (_formKey.currentState!.validate()) {
//       print("Register Called");
//
//       final provider =
//           Provider.of<RegisterUserProvider>(context, listen: false);
//
//       // Call API
//       await provider.registerUser(
//         "+91${widget.phoneController?.text}",
//         _emailController.text,
//         _nameController.text,
//         _businessNameController.text,
//       );
//
//       final commanWidgets = CommanWidgets();
//
//       if (provider.registerUserModel?.success == true) {
//         // Success → go to MainScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const MainScreen()),
//         );
//
//         // Optional: success message
//         commanWidgets.showCustomSnackBar(
//           context,
//           message: "Registration successful!",
//           isError: false,
//         );
//       } else {
//         // Show API message in stylish SnackBar
//         commanWidgets.showCustomSnackBar(
//           context,
//           message:
//               provider.registerUserModel?.message ?? "Something went wrong",
//           isError: true,
//         );
//       }
//     }
//   }
//
//   ///  COMMON INPUT DECORATION
//   InputDecoration _inputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.white70),
//       prefixIcon: Icon(icon, color: Colors.white),
//       filled: true,
//       fillColor: Colors.transparent,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           color: Colors.white70,
//           width: 1.5,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           color: Colors.white,
//           width: 2,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           color: Colors.redAccent,
//           width: 1.5,
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//           color: Colors.red,
//           width: 2,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               AppTheme.royalPurple,
//               AppTheme.deepBlue,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//
//               /// LOGO
//               Center(
//                 child: Container(
//                   width: 130,
//                   height: 130,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
//                   ),
//                   child: Image.asset(
//                     AppImages.appSplashLogo,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: AppTheme.spacing12),
//
//               /// APP NAME
//               Consumer<LanguageProvider>(
//                 builder: (_, lang, __) {
//                   return Text(
//                     lang.getText('app_name'),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 34,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: AppTheme.spacing8),
//
//               /// TAGLINE
//               Consumer<LanguageProvider>(
//                 builder: (_, lang, __) {
//                   return Text(
//                     lang.getText('tagline'),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey,
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: AppTheme.spacing24),
//
//               /// REGISTER FORM CARD
//               Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Card(
//                     elevation: 4,
//                     shadowColor: Colors.black.withOpacity(0.1),
//                     child: Padding(
//                       padding: const EdgeInsets.all(AppTheme.spacing24),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             ///  TITLE + SUBTITLE
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "Register",
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.w800,
//                                     color: Colors.white,
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Let’s get you started 🚀",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white60,
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//
//                             const SizedBox(height: AppTheme.spacing24),
//
//                             /// Name
//                             TextFormField(
//                               controller: _nameController,
//                               style: const TextStyle(color: Colors.white),
//                               decoration: _inputDecoration(
//                                   "Full Name", Icons.person_outline),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Enter full name";
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: AppTheme.spacing16),
//
//                             /// Business Name
//                             TextFormField(
//                               controller: _businessNameController,
//                               style: const TextStyle(color: Colors.white),
//                               decoration: _inputDecoration(
//                                   "Business Name", Icons.business_outlined),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Enter business name";
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: AppTheme.spacing16),
//
//                             /// Email
//                             TextFormField(
//                               controller: _emailController,
//                               style: const TextStyle(color: Colors.white),
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: _inputDecoration(
//                                   "Email", Icons.email_outlined),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Enter email";
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: AppTheme.spacing16),
//
//                             /// Phone
//                             TextFormField(
//                               controller: widget.phoneController,
//                               style: const TextStyle(color: Colors.white),
//                               keyboardType: TextInputType.phone,
//                               decoration: _inputDecoration(
//                                       "Phone", Icons.phone_outlined)
//                                   .copyWith(
//                                 prefixText: '+91 ',
//                                 prefixStyle: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 LengthLimitingTextInputFormatter(10),
//                               ],
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your mobile number';
//                                 }
//                                 if (value.length != 10) {
//                                   return 'Enter valid 10-digit mobile number';
//                                 }
//                                 return null;
//                               },
//                             ),
//
//                             const SizedBox(height: AppTheme.spacing24),
//
//                             /// 🔥 BUTTON
//                             SizedBox(
//                               height: 50,
//                               child: Consumer<RegisterUserProvider>(
//                                 builder: (_, controller, __) {
//                                   return ElevatedButton(
//                                     onPressed: controller.isLoading
//                                         ? null
//                                         : _handleRegister,
//                                     child: controller.isLoading
//                                         ? const SizedBox(
//                                             height: 18,
//                                             width: 18,
//                                             child: CircularProgressIndicator(
//                                                 color: Colors.white),
//                                           )
//                                         : const Text("Register"),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: AppTheme.spacing16),
//
//               /// Powerd By
//               Consumer2<LanguageProvider, ThemeProvider>(
//                 builder: (_, lang, theme, __) {
//                   return Column(
//                     children: [
//                       const SizedBox(height: 16),
//                       Text(
//                         lang.getText('powerd_by'),
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.openSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: theme.isDarkMode
//                               ? AppTheme.darkTextSecondary
//                               : AppTheme.lightTextSecondary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         lang.getText('team_picory'),
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.openSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.5,
//                           color: theme.isDarkMode
//                               ? Colors.white
//                               : AppTheme.royalPurple, // Stylish accent color
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/language_provider.dart';
import '../controllers/register_user_provider.dart';
import '../controllers/theme_provider.dart';
import '../ui_helpers/app_images.dart';
import '../ui_helpers/app_theme.dart';
import '../ui_helpers/comman_widgets.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  final TextEditingController? phoneController;
  const RegisterScreen({super.key, this.phoneController});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final provider =
      Provider.of<RegisterUserProvider>(context, listen: false);

      await provider.registerUser(
        "+91${widget.phoneController?.text}",
        _emailController.text,
        _nameController.text,
        _businessNameController.text,
      );

      final commanWidgets = CommanWidgets();

      if (provider.registerUserModel?.success == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );

        commanWidgets.showCustomSnackBar(
          context,
          message: "Registration successful!",
          isError: false,
        );
      } else {
        commanWidgets.showCustomSnackBar(
          context,
          message:
          provider.registerUserModel?.message ?? "Something went wrong",
          isError: true,
        );
      }
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white70, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final isSmall = width < 360;
    final isTablet = width > 600;

    final horizontalPadding = width * 0.05;
    final logoSize = isSmall ? 90.0 : 130.0;
    final titleFontSize = isSmall ? 26.0 : 34.0;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.royalPurple, AppTheme.deepBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.02),

                /// LOGO
                Center(
                  child: SizedBox(
                    width: logoSize,
                    height: logoSize,
                    child: Image.asset(AppImages.appSplashLogo),
                  ),
                ),

                SizedBox(height: height * 0.02),

                /// APP NAME
                Consumer<LanguageProvider>(
                  builder: (_, lang, __) {
                    return Text(
                      lang.getText('app_name'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.01),

                /// TAGLINE
                Consumer<LanguageProvider>(
                  builder: (_, lang, __) {
                    return Text(
                      lang.getText('tagline'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmall ? 12 : 14,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.03),

                /// FORM
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 500 : double.infinity,
                    ),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(isSmall ? 16 : 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: isSmall ? 20 : 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(height: height * 0.02),

                              /// Name
                              TextFormField(
                                controller: _nameController,
                                style:
                                const TextStyle(color: Colors.white),
                                decoration: _inputDecoration(
                                    "Full Name", Icons.person),
                              ),

                              SizedBox(height: height * 0.02),

                              /// Business
                              TextFormField(
                                controller: _businessNameController,
                                style:
                                const TextStyle(color: Colors.white),
                                decoration: _inputDecoration(
                                    "Business Name", Icons.business),
                              ),

                              SizedBox(height: height * 0.02),

                              /// Email
                              TextFormField(
                                controller: _emailController,
                                style:
                                const TextStyle(color: Colors.white),
                                decoration: _inputDecoration(
                                    "Email", Icons.email),
                              ),

                              SizedBox(height: height * 0.02),

                              /// Phone
                              TextFormField(
                                controller: widget.phoneController,
                                style:
                                const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                decoration: _inputDecoration(
                                    "Phone", Icons.phone)
                                    .copyWith(prefixText: '+91 '),
                              ),

                              SizedBox(height: height * 0.03),

                              /// BUTTON
                              Consumer<RegisterUserProvider>(
                                builder: (_, controller, __) {
                                  return SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: controller.isLoading
                                          ? null
                                          : _handleRegister,
                                      child: controller.isLoading
                                          ? const CircularProgressIndicator(
                                          color: Colors.white)
                                          : const Text("Register"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Footer
                Consumer2<LanguageProvider, ThemeProvider>(
                  builder: (_, lang, theme, __) {
                    return Column(
                      children: [
                        Text(
                          lang.getText('powerd_by'),
                          style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          lang.getText('team_picory'),
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}